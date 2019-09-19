//
//  ConstantCellVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 22/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class ConstantCellVMTests: XCTestCase {
    
    var recipeConstant: RecipeConstant!
    
    var constantCellVM: ConstantCellVM!
    
    override func setUp() {
        super.setUp()
        
        recipeConstant = MockBrewVars.constants[0]
        constantCellVM = ConstantCellVM(constant: recipeConstant)
    }
    
    func testInit() {
        let expectedLabel = recipeConstant.stringifier?.labelText()
        let expectedValueText = recipeConstant.stringifier?.toString(value: recipeConstant.value)
        
        XCTAssertEqual(expectedLabel, constantCellVM.cellLabelText)
        XCTAssertEqual(expectedValueText, constantCellVM.cellValueText)
    }
    
    func testBaseTableCellProperties() {
        let expectedCellIdentifier = "ConstantCellVM"
        let expectedCellHeight: CGFloat = 35
        
        XCTAssertEqual(expectedCellIdentifier, constantCellVM.identifier)
        XCTAssertEqual(expectedCellHeight, constantCellVM.cellHeight)
    }
}
