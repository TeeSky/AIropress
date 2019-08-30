//
//  BrewPrepVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 28/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class MockBrewPrepSceneFC: BrewPrepSceneFC {
    
    var brewInitiated: Bool?
    
    func onBrewInitiated() {
        brewInitiated = true
    }
}

class BrewPrepVMTests: XCTestCase {
    
    var prepParams: PrepParams!
    
    var brewPrepVM: BrewPrepVM!
    
    override func setUp() {
        super.setUp()
        
        prepParams = PrepParams(prepSteps: [.preheatWater("86C"), .rinseFilter, .rinseAeropress, .prepareKettle])
        brewPrepVM = BrewPrepVM(prepParams: prepParams)
    }
    
    func testCellViewModelsCount() {
        let expectedCellCount = prepParams.prepSteps.count
        
        XCTAssertEqual(expectedCellCount, brewPrepVM.cellViewModels.count)
    }
    
    func testCellViewModelsTexts() {
        let expectedCellTextsWithoutIndex = prepParams.prepSteps.map { $0.text() }
        
        for (index, vm) in brewPrepVM.cellViewModels.enumerated() {
            let prepStepCellVM = vm as? PrepStepCellVM
            
            let expectedCellText = "\(index + 1). \(expectedCellTextsWithoutIndex[index])"
            
            XCTAssertEqual(expectedCellText, prepStepCellVM?.cellText)
        }
    }
    
    func testOnBrewClicked() {
        let flowController = MockBrewPrepSceneFC()
        brewPrepVM.flowController = flowController
        let expectedBrewInitiated = true
        
        brewPrepVM.onBrewClicked()
        
        XCTAssertEqual(expectedBrewInitiated, flowController.brewInitiated)
    }
}
