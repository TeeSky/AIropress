//
//  SemiConstantCellVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 22/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class SemiConstantCellVM {
    
    static let cellIdentifier: String = {
        return "SemiConstantCellVM"
    }()
    
    static let cellHeight: CGFloat = {
        let labelHeight = 35
        let sliderHeight = BrewVariableSlider.height
        return CGFloat(labelHeight + sliderHeight)
    }()
    
    var cellLabel: String {
        return semiConstant.label
    }
    
    var cellValueText: String {
        return semiConstant.valueText
    }
    
    var confidenceVariable: BrewVariable {
        return semiConstant.confidenceVariable
    }
    
    var confidenceValue: Double {
        return semiConstant.confidenceValue
    }
    
    private let semiConstant: RecipeSemiConstant
    
    init(semiConstant: RecipeSemiConstant) {
        self.semiConstant = semiConstant
    }
    
    func onSliderValueChanged(to value: Float) {
        semiConstant.confidenceValue = Double(value)
    }
}

extension SemiConstantCellVM: BaseTableCellVM {
    
    var identifier: String {
        return SemiConstantCellVM.cellIdentifier
    }
    
    var cellHeight: CGFloat {
        return SemiConstantCellVM.cellHeight
    }
    
}

class SemiConstantCellVMTests: XCTestCase {

    var recipeSemiConstant: RecipeSemiConstant!
    
    var semiConstantCellVM: SemiConstantCellVM!
    
    override func setUp() {
        super.setUp()
        
        recipeSemiConstant = MockBrewVars.semiConstants[0]
        semiConstantCellVM = SemiConstantCellVM(semiConstant: recipeSemiConstant)
    }
    
    func testInit() {
        let expectedLabel = recipeSemiConstant.label
        let expectedValueText = recipeSemiConstant.valueText
        let expectedConfidenceVariable = recipeSemiConstant.confidenceVariable
        
        XCTAssertEqual(expectedLabel, semiConstantCellVM.cellLabel)
        XCTAssertEqual(expectedValueText, semiConstantCellVM.cellValueText)
        XCTAssertEqual(expectedConfidenceVariable, semiConstantCellVM.confidenceVariable)
    }

    func testOnSliderValueChanged() {
        let passedValue: Float = 0.2
        let expectedConfidenceValue = Double(passedValue)
        
        semiConstantCellVM.onSliderValueChanged(to: passedValue)
        
        XCTAssertEqual(expectedConfidenceValue, semiConstantCellVM.confidenceValue)
    }
}
