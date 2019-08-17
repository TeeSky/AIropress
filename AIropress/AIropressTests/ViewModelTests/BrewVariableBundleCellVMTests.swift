//
//  BrewVariableBundleCellVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 17/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class BrewVariableBundleCellVM {
    
    let variableBundle: BrewVariableBundle
    
    init(variableBundle: BrewVariableBundle) {
        self.variableBundle = variableBundle
    }
    
}

class BrewVariableBundleCellVMTests: BaseTestCase {

    var brewVariableBundle: BrewVariableBundle!
    
    var variableBundleCellVM: BrewVariableBundleCellVM!
    
    override func setUp() {
        super.setUp()
        
        brewVariableBundle = MockBrewVariables.tasteBundle
        
        variableBundleCellVM = BrewVariableBundleCellVM(variableBundle: brewVariableBundle)
    }
    
    func testInit() {
        let expectedVariableBundle = brewVariableBundle
        
        let variableBundleCellVM = BrewVariableBundleCellVM(variableBundle: brewVariableBundle)
        
        XCTAssertEqual(expectedVariableBundle, variableBundleCellVM.variableBundle)
    }

}
