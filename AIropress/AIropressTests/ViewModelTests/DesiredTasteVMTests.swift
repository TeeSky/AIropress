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
    func numberOfRows(in section: Int) -> Int
    func cellViewModel(for path: IndexPath) -> BaseTableCellVM
}

class DesiredTasteVM: BaseTableVM {
    
    let brewParameters: BrewParametersImpl
    
    init(brewVariableBundles: [BrewVariableBundle], values: [BrewVariable.Id: Double?] = [:]) {
        self.brewParameters = BrewParametersImpl(brewVariableBundles: brewVariableBundles, values: values)
    }
    
    func numberOfSections() -> Int {
        return 0
    }
    
    func numberOfRows(in section: Int) -> Int {
        return 0
    }
    
    func cellViewModel(for path: IndexPath) -> BaseTableCellVM {
        return MockTableCellVM()
    }
    
}

class MockTableCellVM: BaseTableCellVM {
    var identifier: String {
        return "xyz"
    }
}

class DesiredTasteVMTests: XCTestCase {
    
    var brewVariableBundles: [BrewVariableBundle]!
    var desiredTasteVM: DesiredTasteVM!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        brewVariableBundles = MockBrewVariables.bundles
        desiredTasteVM = DesiredTasteVM(brewVariableBundles: brewVariableBundles)
    }
    
    func testInit() {
        let expectedBrewParameters = BrewParametersImpl(brewVariableBundles: brewVariableBundles, values: [:])
        let unexpectedBrewParameters1 = BrewParametersImpl(brewVariableBundles: [MockBrewVariables.acidityBundle], values: [:])
        let unexpectedBrewParameters2 = BrewParametersImpl(brewVariableBundles: brewVariableBundles, values: [brewVariableBundles[0].variables[0].id: 0.9])
        
        let desiredTasteVM = DesiredTasteVM(brewVariableBundles: brewVariableBundles)
        
        XCTAssertEqual(expectedBrewParameters, desiredTasteVM.brewParameters)
        XCTAssertNotEqual(unexpectedBrewParameters1, desiredTasteVM.brewParameters)
        XCTAssertNotEqual(unexpectedBrewParameters2, desiredTasteVM.brewParameters)
    }
}
