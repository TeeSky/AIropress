//
//  AIProcessingVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 21/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class AIProcessingVM: BaseViewModel {
    
    weak var flowController: AIProcessingSceneFC?
    
    let brewParameters: BrewParameters
    
    init(brewParameters: BrewParameters) {
        self.brewParameters = brewParameters
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
}
