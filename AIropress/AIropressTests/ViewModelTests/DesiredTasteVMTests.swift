//
//  DesiredTasteVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 17/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

protocol BaseViewModel {
}

protocol BaseTableCellVM {
    var identifier: String { get }
}

protocol BaseTableVM: BaseViewModel {
    func numberOfSections() -> Int
    func numberOfRows(section: Int) -> Int
    func cellViewModel(for path: IndexPath) -> BaseTableCellVM
}

class DesiredTasteVM {
    
    private(set) var cellVMs: [BrewVariableBundleCellVM]
    let brewParameters: BrewParameters
    
    weak var flowController: DesiredTasteSceneFC?
    
    init(brewVariableBundles: [BrewVariableBundle], values: [BrewVariable.Id: Double?] = [:]) {
        self.brewParameters = BrewParameters(brewVariableBundles: brewVariableBundles, values: values)
        
        self.cellVMs = []
        for variableBundle in brewVariableBundles {
            let vm = BrewVariableBundleCellVM(variableBundle: variableBundle)
            vm.valueDelegate = self
            cellVMs.append(vm)
        }
    }

    func onCalculateClicked() {
        flowController?.onParametersSet(brewParameters: brewParameters)
    }
}

extension DesiredTasteVM: VariableBundleCellValueDelegate {
    
    func onValueChanged(brewVariable: BrewVariable, value: Double) {
        brewParameters.valueMap[brewVariable.id] = value
    }
    
}

extension DesiredTasteVM: BaseTableVM {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(section: Int) -> Int {
        guard section == 0 else { fatalError("Unexpected section") }
        
        return cellVMs.count
    }
    
    func cellViewModel(for path: IndexPath) -> BaseTableCellVM {
        guard path.section == 0 else { fatalError("Unexpected section") }
        
        return cellVMs[path.row]
    }
    
}

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
