//
//  SemiConstantCellVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 22/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class SemiConstantCellVMTests: XCTestCase {

    var recipeSemiConstant: RecipeSemiConstant!
    
    var semiConstantCellVM: SemiConstantCellVM!
    
    override func setUp() {
        super.setUp()
        
        recipeSemiConstant = MockBrewVars.semiConstants[0]
        semiConstantCellVM = SemiConstantCellVM(semiConstant: recipeSemiConstant)
    }
    
    func testInit() {
        let expectedLabel = recipeSemiConstant.constant.stringifier?.labelText()
        let expectedValueText = recipeSemiConstant.constant.stringifier?.toString(value: recipeSemiConstant.constant.value)
        let expectedConfidenceVariable = recipeSemiConstant.confidenceVariable
        
        XCTAssertEqual(expectedLabel, semiConstantCellVM.cellLabelText)
        XCTAssertEqual(expectedValueText, semiConstantCellVM.cellValueText)
        XCTAssertEqual(expectedConfidenceVariable, semiConstantCellVM.confidenceVariable)
    }

    func testOnSliderValueChanged() {
        let passedValue: Float = 0.2
        let expectedConfidenceValue = Double(passedValue)
        
        semiConstantCellVM.onSliderValueChanged(to: passedValue)
        
        XCTAssertEqual(expectedConfidenceValue, semiConstantCellVM.confidenceValue)
    }
    
    func testBaseTableCellProperties() {
        let expectedCellIdentifier = "SemiConstantCellVM"
        let expectedCellHeight = CGFloat(35 + BrewVariableSlider.height)
        
        XCTAssertEqual(expectedCellIdentifier, semiConstantCellVM.identifier)
        XCTAssertEqual(expectedCellHeight, semiConstantCellVM.cellHeight)
    }
}
