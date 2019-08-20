//
//  BrewVariableBundleCellTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 19/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class MockBrewVariableBundleCellVM: BrewVariableBundleCellVM {
    
    var valueChange: (BrewVariable, valueIndex: Int)?
    
    override func onSliderValueChanged(brewVariable: BrewVariable, valueIndex: Int) {
        valueChange = (brewVariable, valueIndex)
    }
}

class BrewVariableBundleCellTests: XCTestCase {

    var viewModel: MockBrewVariableBundleCellVM!
    var brewVariableBundleCell: BrewVariableBundleCell!
    
    override func setUp() {
        super.setUp()
        
        viewModel = MockBrewVariableBundleCellVM(variableBundle: MockBrewVars.tasteBundle)
        brewVariableBundleCell = BrewVariableBundleCell()
        brewVariableBundleCell.configure(viewModel: viewModel)
    }
    
    func testLabelText() {
        let expectedLabel = viewModel.variableBundle.label
        
        XCTAssertEqual(expectedLabel, brewVariableBundleCell.label.text)
    }
    
    func testSliderCount() {
        let expectedSliderCount = viewModel.variableBundle.variables.count
        
        XCTAssertEqual(expectedSliderCount, brewVariableBundleCell.sliders.count)
    }
    
    func testSliderValueOnChange() {
        let variableIndex = 0
        let brewVariable = viewModel.variableBundle.variables[variableIndex]
        let value = brewVariable.stepCount - 1
        let expectedSliderValueChange = (brewVariable, value)
        
        brewVariableBundleCell.sliders[variableIndex].delegate!(SliderValue(index: value, raw: Float(value) / Float(brewVariable.stepCount), text: "test"))
        
        XCTAssertEqual(expectedSliderValueChange.0, viewModel.valueChange!.0)
        XCTAssertEqual(expectedSliderValueChange.1, viewModel.valueChange!.1)
    }
}
