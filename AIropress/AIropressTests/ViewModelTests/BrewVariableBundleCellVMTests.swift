//
//  BrewVariableBundleCellVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 17/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest


class MockValueDelegate: VariableBundleCellValueDelegate {
    
    var valueChange: (BrewVariable, Double)? = nil
    
    func onValueChanged(brewVariable: BrewVariable, value: Double) {
        valueChange = (brewVariable, value)
    }
}

class BrewVariableBundleCellVMTests: XCTestCase{

    var brewVariableBundle: BrewVariableBundle!
    
    var variableBundleCellVM: BrewVariableBundleCellVM!
    
    override func setUp() {
        super.setUp()
        
        brewVariableBundle = MockBrewVars.tasteBundle
        
        variableBundleCellVM = BrewVariableBundleCellVM(variableBundle: brewVariableBundle)
    }
    
    func testInit() {
        let expectedVariableBundle = brewVariableBundle
        
        let variableBundleCellVM = BrewVariableBundleCellVM(variableBundle: brewVariableBundle)
        
        XCTAssertEqual(expectedVariableBundle, variableBundleCellVM.variableBundle)
    }
    
    func testOnSliderValueChanged() {
        let expectedBrewVariable = MockBrewVars.bitternessVariable
        let valueIndex = 2
        let expectedDoubleValue = Double((valueIndex + 1)) / Double(expectedBrewVariable.stepCount)
        let valueDelegate = MockValueDelegate()
        variableBundleCellVM.valueDelegate = valueDelegate
        
        variableBundleCellVM.onSliderValueChanged(brewVariable: expectedBrewVariable, valueIndex: valueIndex)
        
        XCTAssertNotNil(valueDelegate.valueChange)
        XCTAssertEqual(expectedBrewVariable, valueDelegate.valueChange!.0)
        XCTAssertEqual(expectedDoubleValue, valueDelegate.valueChange!.1)
    }
    
    func testBaseTableCellVMIdentifier() {
        let expectedCellIdentifier = BrewVariableBundleCellVM.cellIdentifier
        
        XCTAssertEqual(expectedCellIdentifier, variableBundleCellVM.identifier)
    }
}
