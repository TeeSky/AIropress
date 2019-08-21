//
//  AIProcessingVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 21/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

private class MockAIProcessingSceneFC: AIProcessingSceneFC {
    
    var expectation: XCTestExpectation?
    
    func onProcessingDone(recipe: BrewRecipe) {
        expectation?.fulfill()
    }
}

private class MockAIProcessingVMDelegate: AIProcessingVMDelegate {
    
    var labelText: String?
    var processingDone: Bool?

    var activitityIndicatorAnimating: Bool?
    
    func setProgressLabel(text: String) {
        labelText = text
    }
    
    func onProcessingDone() {
        processingDone = true
    }
    
    func setActivityIndicatorState(animating: Bool) {
        activitityIndicatorAnimating = animating
    }
    
}

class AIProcessingVMTests: XCTestCase {
    
    private var brewParameters: BrewParameters!
    private var flowController: MockAIProcessingSceneFC!
    private var delegate: MockAIProcessingVMDelegate!
    
    private var aiProcessingVM: AIProcessingVM!
    
    override func setUp() {
        super.setUp()
        
        brewParameters = MockBrewVars.brewParameters
        flowController = MockAIProcessingSceneFC()
        delegate = MockAIProcessingVMDelegate()
        
        aiProcessingVM = AIProcessingVM(brewParameters: brewParameters)
        aiProcessingVM.flowController = flowController
        aiProcessingVM.delegate = delegate
    }
    
    func testInit() {
        let expectedBrewParameters = brewParameters
        
        XCTAssertEqual(expectedBrewParameters, aiProcessingVM.brewParameters)
    }
    
    func testOnViewDidLoad() {
        let expectedLabelText = "Processing..."
        let expectedIndicatorAnimating = true
        
        aiProcessingVM.onViewDidLoad()
        
        XCTAssertEqual(expectedLabelText, delegate.labelText)
        XCTAssertEqual(expectedIndicatorAnimating, delegate.activitityIndicatorAnimating)
    }
    
    func testOnSceneDidAppear() {
        let expectation = XCTestExpectation(description: "Process the BrewParameters into BrewRecipe and call FC.")
        flowController.expectation = expectation
        let expectedLabelTextAfter = "Processing done."
        let expectedIndicatorAnimating = false
        
        aiProcessingVM.onSceneDidAppear()
        
        wait(for: [expectation], timeout: 7.0)
        XCTAssertEqual(expectedLabelTextAfter, delegate.labelText)
        XCTAssertEqual(expectedIndicatorAnimating, delegate.activitityIndicatorAnimating)
    }
}
