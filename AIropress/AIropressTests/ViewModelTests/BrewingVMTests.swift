//
//  BrewingVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 11/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

struct PhaseTextSet {
    let labelText: String
    let timerText: String
}

protocol BrewingVMDelegate: class {
    func setTimerTexts(mainTimerText: String, currentPhaseTimerText: String)
    func setNextPhaseTexts(textSets: [PhaseTextSet])
}

class BrewingVM: BaseViewModel {
    
    private(set) var currentTotalTicks: Int
    private(set) var currentBrewPhaseIndex: Int
    private(set) var currentBrewPhaseTimer: BrewPhaseTimer?
    
    lazy var totalBrewTime: Double = {
        return brewPhases.map({ $0.duration }).reduce(0, +)
    }()
    
    var nextPhaseTexts: [PhaseTextSet] {
        let startIndex = currentBrewPhaseIndex
        let endIndex = startIndex + 2
        
        let nextBrewPhases = Array(brewPhases[currentBrewPhaseIndex...endIndex])
        return nextBrewPhases.map { PhaseTextSet(labelText: $0.label, timerText: $0.duration.asStopwatchString())}
    }
    
    let brewPhases: [BrewPhase]
    let brewTimerType: BrewPhaseTimer.Type
    
    weak var delegate: BrewingVMDelegate?
    weak var flowController: BrewingSceneFC?
    
    init(brewPhases: [BrewPhase], timerType: BrewPhaseTimer.Type = BrewPhaseTimer.self) {
        self.currentTotalTicks = 0
        self.currentBrewPhaseIndex = 0
        self.brewPhases = brewPhases
        self.brewTimerType = timerType
    }
    
    func onResetClicked() {
        flowController?.onRecipeReset()
    }
    
    func onSceneDidAppear() {
        delegate?.setNextPhaseTexts(textSets: nextPhaseTexts)
        
        startPhaseTimer()
    }
    
    private func onPhaseTick(remainingSeconds: Double) {
        currentTotalTicks += 1
        
        let totalRemainingSeconds = (totalBrewTime - Double(currentTotalTicks)).rounded(.towardZero)
        let mainTimerText = totalRemainingSeconds.asStopwatchString()
        
        let phaseTimerText = remainingSeconds.asStopwatchString()
        
        delegate?.setTimerTexts(mainTimerText: mainTimerText, currentPhaseTimerText: phaseTimerText)
    }
    
    private func onPhaseEnd() {
        currentBrewPhaseIndex += 1
        guard currentBrewPhaseIndex < brewPhases.count else {
            flowController?.onBrewFinished()
            return
        }
        
        startPhaseTimer()
    }
    
    private func startPhaseTimer() {
        currentTotalTicks = 0
        currentBrewPhaseTimer = brewTimerType.init(brewPhase: brewPhases[currentBrewPhaseIndex],
                                               tickDelegate: onPhaseTick, phaseEndDelegate: onPhaseEnd)
    }
}

private class MockBrewingSceneFC: BrewingSceneFC {
    
    var recipeReset: Bool?
    var brewFinished: Bool?
    
    func onRecipeReset() {
        recipeReset = true
    }
    
    func onBrewFinished() {
        brewFinished = true
    }
    
}

private class MockBrewingVMDelegate: BrewingVMDelegate {
    
    var mainTimerText: String?
    var currentPhaseTimerText: String?
    
    var nextPhaseTextSets: [PhaseTextSet]?
    
    func setTimerTexts(mainTimerText: String, currentPhaseTimerText: String) {
        self.mainTimerText = mainTimerText
        self.currentPhaseTimerText = currentPhaseTimerText
    }
    
    func setNextPhaseTexts(textSets: [PhaseTextSet]) {
        nextPhaseTextSets = textSets
    }
    
}

private class MockBrewPhaseTimer: BrewPhaseTimer {
    
    required init(brewPhase: BrewPhase, tickDelegate: @escaping TickDelegate, phaseEndDelegate: @escaping PhaseEndDelegate, autostartTimers: Bool = true, timerProvider: Timer.Type = Timer.self) {
        super.init(brewPhase: brewPhase, tickDelegate: tickDelegate, phaseEndDelegate: phaseEndDelegate, autostartTimers: false)
    }
}

class BrewingVMTests: XCTestCase {

    var brewPhases: [BrewPhase]!
    
    var brewingVM: BrewingVM!
    
    override func setUp() {
        super.setUp()
        
        brewPhases = AeroPressBrewingPlan(waterAmount: 50, coffeeAmount: 13, bloomDuration: 20, brewDuration: 35).orderedPhases

        brewingVM = BrewingVM(brewPhases: brewPhases, timerType: MockBrewPhaseTimer.self)
    }
    
    func testInitBrewPhases() {
        let expectedBrewPhaseCount = brewPhases.count
        XCTAssertGreaterThan(expectedBrewPhaseCount, 0) // Sanity/validity check
        
        XCTAssertEqual(expectedBrewPhaseCount, brewingVM.brewPhases.count)
        
        for (index, expectedBrewPhase) in brewPhases.enumerated() {
            XCTAssertEqual(expectedBrewPhase, brewingVM.brewPhases[index])
        }
    }
    
    func testTotalBrewTime() {
        var expectedTotalTime = 0.0
        for brewPhase in brewPhases {
            expectedTotalTime += brewPhase.duration
        }
        
        XCTAssertEqual(expectedTotalTime, brewingVM.totalBrewTime)
    }
    
    // test nextPhaseTexts
    
    func testOnResetClicked() {
        let flowController = MockBrewingSceneFC()
        let expectedResetClicked = true
        
        brewingVM.flowController = flowController
        brewingVM.onResetClicked()
        
        XCTAssertEqual(expectedResetClicked, flowController.recipeReset)
    }
    
    func testOnSceneDidAppearPhase() {
        let expectedInitialPhaseIndex = 0
        let expectedInitialBrewPhase = brewPhases[expectedInitialPhaseIndex]
        let expectedInitialPhaseDuration = expectedInitialBrewPhase.duration
        let expectedInitialTicks = 0
        
        brewingVM.onSceneDidAppear()
        
        XCTAssertEqual(expectedInitialTicks, brewingVM.currentTotalTicks)
        XCTAssertEqual(expectedInitialPhaseIndex, brewingVM.currentBrewPhaseIndex)
        XCTAssertEqual(expectedInitialPhaseDuration, brewingVM.currentBrewPhaseTimer?.phaseDuration)
        
        // test delegate phase texts
    }
    
    func testOnPhaseTick() {
        let expectedTicks = 2
        let tickValue = 3.0
        let expectedCurrentPhaseTimerText = "00:03"
        
        XCTAssertEqual(100, brewingVM.totalBrewTime) // Pre-test state check
        let expectedMainTimerText = "01:38" // 100 - 2 seconds
        
        let mockVMDelegate = MockBrewingVMDelegate()
        brewingVM.delegate = mockVMDelegate
        
        brewingVM.onSceneDidAppear()
        for _ in 1...expectedTicks {
            brewingVM.currentBrewPhaseTimer!.tickDelegate(tickValue)
        }
        
        XCTAssertEqual(expectedTicks, brewingVM.currentTotalTicks)
        XCTAssertEqual(expectedCurrentPhaseTimerText, mockVMDelegate.currentPhaseTimerText)
        XCTAssertEqual(expectedMainTimerText, mockVMDelegate.mainTimerText)
    }
    
    // test onPhaseEnd
}
