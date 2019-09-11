//
//  BrewingVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 11/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class BrewingVM: BaseViewModel {
    
    let brewPhases: [BrewPhase]
    let timerProvider: Timer.Type
    
    weak var flowController: BrewingSceneFC?
    
    init(brewPhases: [BrewPhase], timerProvider: Timer.Type) {
        self.brewPhases = brewPhases
        self.timerProvider = timerProvider
    }
    
    func onResetClicked() {
        flowController?.onRecipeReset()
    }
}

class MockBrewingSceneFC: BrewingSceneFC {
    
    var recipeReset: Bool?
    var brewFinished: Bool?
    
    func onRecipeReset() {
        recipeReset = true
    }
    
    func onBrewFinished() {
        brewFinished = true
    }
    
}

class MockTimer: Timer {
    
    var block: ((Timer) -> Void)!
    
    static var currentTimer: Timer?
    
    override func fire() {
        block(self)
    }
    
    override open class func scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) -> Timer {
        let timer = MockTimer()
        
        timer.block = block
        MockTimer.currentTimer = timer
        
        return timer
    }
}

class BrewingVMTests: XCTestCase {

    var brewPhases: [BrewPhase]!
    
    var brewingVM: BrewingVM!
    
    override func setUp() {
        super.setUp()
        
        brewPhases = AeroPressBrewingPlan(waterAmount: 50, coffeeAmount: 13, bloomDuration: 20, brewDuration: 35).orderedPhases

        brewingVM = BrewingVM(brewPhases: brewPhases, timerProvider: MockTimer.self)
    }
    
    func testInitBrewPhases() {
        let expectedBrewPhaseCount = brewPhases.count
        XCTAssertGreaterThan(expectedBrewPhaseCount, 0) // Sanity/validity check
        
        XCTAssertEqual(expectedBrewPhaseCount, brewingVM.brewPhases.count)
        
        for (index, expectedBrewPhase) in brewPhases.enumerated() {
            XCTAssertEqual(expectedBrewPhase, brewingVM.brewPhases[index])
        }
    }
    
    func testOnResetClicked() {
        let flowController = MockBrewingSceneFC()
        let expectedResetClicked = true
        
        brewingVM.flowController = flowController
        brewingVM.onResetClicked()
        
        XCTAssertEqual(expectedResetClicked, flowController.recipeReset)
    }
}
