//
//  BrewParametersTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 17/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

struct MockBrewVars {
    
    static let bitternessLabelSet = VariableLabelSet(mainLabel: "Bitterness", minLabel: "Watery", maxLabel: "Bitter")
    
    static let bitternessVariable = BrewVariable(id: 1, stepCount: 10, labelSet: bitternessLabelSet)
    static let bitternessVariableValue = 0.3
    static let flavourVariable = BrewVariable(id: 2, stepCount: 10, labelSet: VariableLabelSet(mainLabel: "Flavour", minLabel: "Light", maxLabel: "Full"))
    static let flavourVariableValue = 0.7
    
    static let tasteBundle = BrewVariableBundle(label: "Taste",
                                                        variables: [bitternessVariable, flavourVariable])
    static let tasteInitialValues = [bitternessVariable: bitternessVariableValue, flavourVariable: flavourVariableValue]
    
    static let acidityBundle = BrewVariableBundle(label: "Acidity",
                                                          variables: [BrewVariable(id: 3, stepCount: 10, labelSet: VariableLabelSet(mainLabel: "Intensity", minLabel: "Minimal", maxLabel: "Intensive"))])
    
    static let bundles = [tasteBundle,
                          acidityBundle]
    
    static let brewParameters = BrewParameters(brewVariableBundles: bundles, values: [:])
}

class BrewParametersTests: XCTestCase {
    
    var brewVariableBundles: [BrewVariableBundle]!
    var values: [BrewVariable.Id: Double?]!
    
    var parameters: BrewParameters!

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
