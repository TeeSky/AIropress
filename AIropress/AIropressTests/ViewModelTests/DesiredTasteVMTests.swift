//
//  DesiredTasteVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 17/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

private class MockDesiredTasteFlowController: DesiredTasteSceneFC {
    
    var setParameters: BrewParameters? = nil
    
    func onParametersSet(brewParameters: BrewParameters) {
        setParameters = brewParameters
    }
    
}

class DesiredTasteVMTests: XCTestCase {
    
    private var brewVariableBundles: [BrewVariableBundle]!
    private var desiredTasteVM: DesiredTasteVM!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        brewVariableBundles = MockBrewVars.bundles
        desiredTasteVM = DesiredTasteVM(brewVariableBundles: brewVariableBundles)
    }
    
    func testInit() {
        let expectedBrewParameters = BrewParameters(brewVariableBundles: brewVariableBundles, values: [:])
        let unexpectedBrewParameters1 = BrewParameters(brewVariableBundles: [MockBrewVars.acidityBundle], values: [:])
        let unexpectedBrewParameters2 = BrewParameters(brewVariableBundles: brewVariableBundles, values: [brewVariableBundles[0].variables[0].id: 0.9])
        
        let desiredTasteVM = DesiredTasteVM(brewVariableBundles: brewVariableBundles)
        
        XCTAssertEqual(expectedBrewParameters, desiredTasteVM.brewParameters)
        XCTAssertNotEqual(unexpectedBrewParameters1, desiredTasteVM.brewParameters)
        XCTAssertNotEqual(unexpectedBrewParameters2, desiredTasteVM.brewParameters)
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(1, desiredTasteVM.numberOfSections())
    }
    
    func testNumberOfRows() {
        let expectedNumberOfRows = brewVariableBundles.count
        
        XCTAssertEqual(expectedNumberOfRows, desiredTasteVM.numberOfRows(section: 0))
    }
    
    func testCellViewModelForPath(){
        let cell1Path = IndexPath(row: 0, section: 0)
        let expectedCell1VMBrewVariableBundle = brewVariableBundles[cell1Path.row]
        let cell2Path = IndexPath(row: 1, section: 0)
        let expectedCell2VMBrewVariableBundle = brewVariableBundles[cell2Path.row]
        
        let cell1VM = desiredTasteVM.cellViewModel(for: cell1Path)
        XCTAssertEqual(expectedCell1VMBrewVariableBundle.variables,
                       (cell1VM as? BrewVariableBundleCellVM)?.sliderVariables)
        
        let cell2VM = desiredTasteVM.cellViewModel(for: cell2Path)
        XCTAssertEqual(expectedCell2VMBrewVariableBundle.variables,
                       (cell2VM as? BrewVariableBundleCellVM)?.sliderVariables)
    }
    
    func testHeightForPath() {
        let cell1Path = IndexPath(row: 0, section: 0)
        let expectedCell1Height = desiredTasteVM.cellVMs[cell1Path.row].cellHeight
        let cell2Path = IndexPath(row: 1, section: 0)
        let expectedCell2Height = desiredTasteVM.cellVMs[cell2Path.row].cellHeight
        
        XCTAssertEqual(expectedCell1Height, desiredTasteVM.cellHeight(for: cell1Path))
        XCTAssertEqual(expectedCell2Height, desiredTasteVM.cellHeight(for: cell2Path))
    }
    
    func testOnCalculateClicked() {
        let flowController = MockDesiredTasteFlowController()
        let expectedParameters = BrewParameters(brewVariableBundles: brewVariableBundles, values: [:])
        desiredTasteVM.flowController = flowController
        
        let brewVariableChange = (brewVariableBundles[0].variables[0], 0.1)
        // Change assurance
        XCTAssertNotEqual(expectedParameters.valueMap[brewVariableChange.0.id], brewVariableChange.1)
        expectedParameters.valueMap[brewVariableChange.0.id] = brewVariableChange.1
        desiredTasteVM.cellVMs[0].valueDelegate?.onValueChanged(brewVariable: brewVariableChange.0, value: brewVariableChange.1)
        
        desiredTasteVM.onCalculateClicked()
        
        XCTAssertNotNil(flowController.setParameters)
        XCTAssertEqual(expectedParameters, flowController.setParameters)
    }
}
