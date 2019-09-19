//
//  BrewingVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 11/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

private class MockBrewingSceneFC: BrewingSceneFC {
    
    var brewStopped: Bool?
    var brewFinishedExpectation: XCTestExpectation?
    
    func onBrewStopped() {
        brewStopped = true
    }
    
    func onBrewFinished() {
        brewFinishedExpectation?.fulfill()
    }
    
}

private class MockBrewingVMDelegate: BrewingVMDelegate {
    
    var mainTimerText: String?
    var currentPhaseTimerText: String?
    
    var nextPhaseTextSets: [PhaseTextSet]?
    
    func setTimerTexts(mainTimerText: String, currentPhaseTimerText: String?) {
        self.mainTimerText = mainTimerText
        self.currentPhaseTimerText = currentPhaseTimerText
    }
    
    func setPhaseTexts(textSets: [PhaseTextSet]) {
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
        
        brewPhases = AeroPressFilterPlan(waterAmount: 50, coffeeAmount: 13, bloomDuration: 20, brewDuration: 35).orderedPhases

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
    
    func testNextPhaseTexts() {
        for startIndex in 0...brewPhases.count - 1 {
            let expectedNextPhaseTexts = BrewingVMTests.createPhaseTexts(brewPhases: brewPhases, startIndex: startIndex)
            
            let brewingVM = BrewingVM(brewPhases: brewPhases, startPhaseIndex: startIndex)
            
            XCTAssertEqual(expectedNextPhaseTexts, brewingVM.nextPhaseTexts)
        }
    }
    
    func testOnStopClicked() {
        let flowController = MockBrewingSceneFC()
        let expectedBrewStopped = true
        
        brewingVM.flowController = flowController
        brewingVM.onStopClicked()
        
        XCTAssertEqual(expectedBrewStopped, flowController.brewStopped)
    }
    
    func testOnSceneDidAppearPhase() {
        let expectedInitialPhaseIndex = 0
        let expectedCompletedPhasesDuration = 0.0
        let expectedInitialBrewPhase = brewPhases[expectedInitialPhaseIndex]
        let expectedInitialPhaseDuration = expectedInitialBrewPhase.duration
        let expectedInitialTicks = 0
        XCTAssertEqual(100, brewingVM.totalBrewTime) // Pre-test state check
        let expectedMainTimerText = "01:40" // 100 seconds
        
        let expectedNextPhaseTexts = BrewingVMTests.createPhaseTexts(brewPhases: brewPhases, startIndex: expectedInitialPhaseIndex)
        let mockVMDelegate = MockBrewingVMDelegate()
        brewingVM.delegate = mockVMDelegate
        
        brewingVM.onSceneDidAppear()
        
        XCTAssertEqual(expectedInitialTicks, brewingVM.currentTotalTicks)
        XCTAssertEqual(expectedInitialPhaseIndex, brewingVM.currentBrewPhaseIndex)
        XCTAssertEqual(expectedInitialPhaseDuration, brewingVM.currentBrewPhaseTimer?.phaseDuration)
        XCTAssertEqual(expectedCompletedPhasesDuration, brewingVM.completedPhasesDuration)
        
        XCTAssertEqual(expectedMainTimerText, mockVMDelegate.mainTimerText)
        XCTAssertEqual(expectedNextPhaseTexts, mockVMDelegate.nextPhaseTextSets)
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
    
    func testOnPhaseEnd() {
        let expectedInitialPhaseIndex = 0
        let expectedPhaseEndIndex = expectedInitialPhaseIndex + 1
        let expectedCompletedPhasesDuration = brewPhases[expectedInitialPhaseIndex].duration
        let expectedNextPhaseTexts = BrewingVMTests.createPhaseTexts(brewPhases: brewPhases, startIndex: expectedPhaseEndIndex)
        
        brewingVM.onSceneDidAppear()
        let delegate = MockBrewingVMDelegate()
        brewingVM.delegate = delegate
        
        brewingVM.currentBrewPhaseTimer?.phaseEndDelegate()
        
        XCTAssertEqual(expectedPhaseEndIndex, brewingVM.currentBrewPhaseIndex)
        XCTAssertEqual(expectedNextPhaseTexts, delegate.nextPhaseTextSets)
        XCTAssertEqual(expectedCompletedPhasesDuration, brewingVM.completedPhasesDuration)
    }
    
    func testOnBrewFinished() {
        let expectedInitialPhaseIndex = brewPhases.count - 1
        let expectedPhaseEndIndex = expectedInitialPhaseIndex + 1
        let expectedNextPhaseTexts: [PhaseTextSet]? = []
        let expectedBrewFinished = true
        
        let brewingVM = BrewingVM(brewPhases: brewPhases, startPhaseIndex: expectedInitialPhaseIndex)
        brewingVM.onSceneDidAppear()
        let delegate = MockBrewingVMDelegate()
        brewingVM.delegate = delegate
        let flowController = MockBrewingSceneFC()
        let brewFinishedExpectation = XCTestExpectation(description: "Call onBrewFinished with delay.")
        flowController.brewFinishedExpectation = brewFinishedExpectation
        brewingVM.flowController = flowController
        
        brewingVM.currentBrewPhaseTimer?.phaseEndDelegate()
        
        XCTAssertEqual(expectedPhaseEndIndex, brewingVM.currentBrewPhaseIndex)
        XCTAssertEqual(expectedBrewFinished, brewingVM.brewFinished)
        XCTAssertEqual(expectedNextPhaseTexts, delegate.nextPhaseTextSets)
        
        wait(for: [brewFinishedExpectation], timeout: 2.0)
    }
    
    private static func createPhaseTexts(brewPhases: [BrewPhase], startIndex: Int) -> [PhaseTextSet] {
        let endIndex = min(startIndex + 2, brewPhases.count - 1)
        
        let nextBrewPhases = Array(brewPhases[startIndex...endIndex])
        return nextBrewPhases.map { PhaseTextSet(labelText: $0.label, timerText: $0.duration.asStopwatchString())}
    }
}
