//
//  BrewVariableBundleCellVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 17/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

protocol VariableBundleCellValueDelegate: class {
    func onValueChanged(brewVariable: BrewVariable, value: Double)
}

class BrewVariableBundleCellVM {
    
    static let cellIdentifier: String = {
        return "BrewVariableBundleCellVM"
    }()
    
    let variableBundle: BrewVariableBundle
    
    weak var valueDelegate: VariableBundleCellValueDelegate?
    
    init(variableBundle: BrewVariableBundle) {
        self.variableBundle = variableBundle
    }
    
    func onSliderValueChanged(brewVariable: BrewVariable, valueIndex: Int) {
        let normalizedValue = normalize(sliderValueIndex: valueIndex, of: brewVariable)
        
        valueDelegate?.onValueChanged(brewVariable: brewVariable, value: normalizedValue)
    }
    
    private func normalize(sliderValueIndex: Int, of brewVariable: BrewVariable) -> Double {
        return Double(sliderValueIndex + 1) / Double(brewVariable.stepCount)
    }
}

extension BrewVariableBundleCellVM: BaseTableCellVM {
    
    var identifier: String {
        return BrewVariableBundleCellVM.cellIdentifier
    }
}

class MockValueDelegate: VariableBundleCellValueDelegate {
    
    var valueChange: (BrewVariable, Double)? = nil
    
    func onValueChanged(brewVariable: BrewVariable, value: Double) {
        valueChange = (brewVariable, value)
    }
}

class BrewVariableBundleCellVMTests: BaseTestCase {

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
