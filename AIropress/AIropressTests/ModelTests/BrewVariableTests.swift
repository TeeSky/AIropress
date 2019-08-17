//
//  BrewVariableTests.swift
//  AIropressTests
//
//  Created by Skypy on 17/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

struct BrewVariableBundle: Equatable {
    let label: String
    let variables: [BrewVariable]
}

struct BrewVariable: Equatable {
    typealias Id = Int
    
    let id: Id
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

class BrewVariableTests: BaseTestCase {
    
    var brewVariable: BrewVariable!

    override func setUp() {
        super.setUp()
        
        brewVariable = BrewVariable(id: 1, stepCount: 10, labelSet: MockBrewVars.bitternessLabelSet)
    }
    
    func testHash() {
        let brewVariableId = 4
        let otherBrewVariableId = 5
        let brewVariableWithExpectedHash = BrewVariable(id: brewVariableId, stepCount: 15, labelSet: MockBrewVars.bitternessLabelSet)
        let brewVariableWithUnexpectedHash = BrewVariable(id: otherBrewVariableId, stepCount: 10, labelSet: MockBrewVars.bitternessLabelSet)
        
        let brewVariable = BrewVariable(id: brewVariableId, stepCount: 10, labelSet: MockBrewVars.bitternessLabelSet)
        
        XCTAssertEqual(brewVariable.hashValue, brewVariableWithExpectedHash.hashValue)
        XCTAssertNotEqual(brewVariable.hashValue, brewVariableWithUnexpectedHash.hashValue)
    }
}
