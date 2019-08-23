//
//  BrewParametersTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 17/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class BrewParametersTests: XCTestCase {
    
    private var brewVariableBundles: [BrewVariableBundle]!
    private var values: [BrewVariable.Id: Double?]!
    
    private var parameters: BrewParameters!

    override func setUp() {
        super.setUp()
        
        brewVariableBundles = MockBrewVars.bundles
        
        values = [BrewVariable.Id: Double?]()
        values[brewVariableBundles[0].variables[0].id] = 0.8
        values[brewVariableBundles[1].variables[0].id] = 0.3
        
        parameters = BrewParameters(brewVariableBundles: brewVariableBundles, values: values)
    }

    func testInit() {
        let allVariables = brewVariableBundles.flatMap { $0.variables }
        
        let brewParameters = BrewParameters(brewVariableBundles: brewVariableBundles, values: values)
        
        for brewVariable in allVariables {
            let expectedValue = values[brewVariable.id] ?? BrewParameters.defaultBrewValue
            
            XCTAssertEqual(expectedValue, brewParameters.valueMap[brewVariable.id])
        }
    }

}
