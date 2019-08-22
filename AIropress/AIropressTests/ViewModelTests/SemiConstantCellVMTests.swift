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
        return recipeConstant.label
    }
    
    var cellValueText: String {
        return recipeConstant.valueText
    }
    
    var recipeConstant: RecipeConstant {
        return semiConstant.constant
    }
    
    var confidenceVariable: BrewVariable {
        return semiConstant.confidenceVariable
    }
    
    var confidenceValue: Double {
        return changedConfidenceValue ?? semiConstant.confidenceValue
    }
    
    private let semiConstant: RecipeSemiConstant
    private var changedConfidenceValue: Double?
    
    init(semiConstant: RecipeSemiConstant) {
        self.semiConstant = semiConstant
    }
    
    func onSliderValueChanged(to value: Float) {
        changedConfidenceValue = Double(value)
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
        let expectedLabel = recipeSemiConstant.constant.label
        let expectedValueText = recipeSemiConstant.constant.valueText
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
    
    func testBaseTableCellProperties() {
        let expectedCellIdentifier = "SemiConstantCellVM"
        let expectedCellHeight = CGFloat(35 + BrewVariableSlider.height)
        
        XCTAssertEqual(expectedCellIdentifier, semiConstantCellVM.identifier)
        XCTAssertEqual(expectedCellHeight, semiConstantCellVM.cellHeight)
    }
}
