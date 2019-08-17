//
//  DesiredTasteVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 17/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest


class MockDesiredTasteFlowController: DesiredTasteSceneFC {
    
    var setParameters: BrewParameters? = nil
    
    func onParametersSet(brewParameters: BrewParameters) {
        setParameters = brewParameters
    }
    
}

class DesiredTasteVMTests: XCTestCase {
    
    var brewVariableBundles: [BrewVariableBundle]!
    var desiredTasteVM: DesiredTasteVM!
    
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
        let expectedCell1VMBrewVariableBundle = brewVariableBundles[0]
        let expectedCell2VMBrewVariableBundle = brewVariableBundles[1]
        
        let cell1VM = desiredTasteVM.cellViewModel(for: IndexPath(row: 0, section: 0))
        XCTAssertEqual(expectedCell1VMBrewVariableBundle,
                       (cell1VM as? BrewVariableBundleCellVM)?.variableBundle)
        
        let cell2VM = desiredTasteVM.cellViewModel(for: IndexPath(row: 1, section: 0))
        XCTAssertEqual(expectedCell2VMBrewVariableBundle,
                       (cell2VM as? BrewVariableBundleCellVM)?.variableBundle)
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
