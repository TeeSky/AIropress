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
    
    
    init(brewVariableBundles: [BrewVariableBundle]) {
        
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
//        XCTAssertNotNil(desiredTasteVM.brewParameters)
    }
}
