//
//  AIProcessingVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 21/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

protocol AIProcessingVMDelegate: class {
    func onProcessingDone()
}

class AIProcessingVM: BaseViewModel {
    
    weak var flowController: AIProcessingSceneFC?
    weak var delegate: AIProcessingVMDelegate?
    
    let brewParameters: BrewParameters
    
    init(brewParameters: BrewParameters) {
        self.brewParameters = brewParameters
        
        startProcessing()
    }
    
    func onSceneDidAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Mock code, replace with processing done check.
            self.onProcessingDone()
        }
    }
    
    private func startProcessing() {
        // TODO
    }
    
    private func onProcessingDone() {
        delegate?.onProcessingDone()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.flowController?.onProcessingDone(recipe: BrewRecipe())
        }
    }
}

private class MockAIProcessingSceneFC: AIProcessingSceneFC {
    
    var expectation: XCTestExpectation?
    
    func onProcessingDone(recipe: BrewRecipe) {
        expectation?.fulfill()
    }
}

class AIProcessingVMTests: XCTestCase {
    
    private var brewParameters: BrewParameters!
    private var aiProcessingVM: AIProcessingVM!
    
    override func setUp() {
        super.setUp()
        
        brewParameters = MockBrewVars.brewParameters
        aiProcessingVM = AIProcessingVM(brewParameters: brewParameters)
    }
    
    func testInit() {
        let expectedBrewParameters = brewParameters
        
        XCTAssertEqual(expectedBrewParameters, aiProcessingVM.brewParameters)
    }
    
    func testOnSceneDidAppear() {
        let flowController = MockAIProcessingSceneFC()
        aiProcessingVM.flowController = flowController
        let expectation = XCTestExpectation(description: "Process the BrewParameters into BrewRecipe and call FC.")
        flowController.expectation = expectation
        
        aiProcessingVM.onSceneDidAppear()
        
        wait(for: [expectation], timeout: 7.0)
    }
}
