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

struct BrewVariableBundle {
    let label: String
    let variables: [BrewVariable]
}

struct BrewVariable: Equatable {
    let id: Int
    let stepCount: Int
    let labelSet: VariableLabelSet
}

extension BrewVariable: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct VariableLabelSet: Equatable {
    let mainLabel: String
    let minLabel: String
    let maxLabel: String
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

struct MockBrewVariables {
    
    private static let tasteBundle = BrewVariableBundle(label: "Taste",
                                                              variables: [
                                                                BrewVariable(id: 1, stepCount: 10, labelSet: VariableLabelSet(mainLabel: "Bitterness", minLabel: "Watery", maxLabel: "Bitter")),
                                                                BrewVariable(id: 2, stepCount: 10, labelSet: VariableLabelSet(mainLabel: "Flavour", minLabel: "Light", maxLabel: "Full"))])
    private static let acidityBundle = BrewVariableBundle(label: "Acidity",
                                                          variables: [BrewVariable(id: 3, stepCount: 10, labelSet: VariableLabelSet(mainLabel: "Intensity", minLabel: "Minimal", maxLabel: "Intensive"))])
    
    static let bundles = [MockBrewVariables.tasteBundle,
                          MockBrewVariables.acidityBundle]
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
