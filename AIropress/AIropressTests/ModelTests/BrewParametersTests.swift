//
//  BrewParametersTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 17/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class BrewParametersImpl {
    
    static let defaultBrewValue = 0.5
    
    private(set) var valueMap: [BrewVariable.Id: Double]
    
    convenience init(brewVariableBundles: [BrewVariableBundle], values: [BrewVariable.Id: Double?]) {
        self.init(brewVariables: brewVariableBundles.flatMap { $0.variables }, values: values)
    }
    
    init(brewVariables: [BrewVariable], values: [BrewVariable.Id: Double?]) {
        self.valueMap = brewVariables.reduce(into: [BrewVariable.Id: Double]()) {
            $0[$1.id] = values[$1.id] ?? BrewParametersImpl.defaultBrewValue
        }
    }
}

extension BrewParametersImpl: Equatable {
    
    static func == (lhs: BrewParametersImpl, rhs: BrewParametersImpl) -> Bool {
        return lhs.valueMap == rhs.valueMap
    }
    
}

struct MockBrewVars {
    
    static let bitternessLabelSet = VariableLabelSet(mainLabel: "Bitterness", minLabel: "Watery", maxLabel: "Bitter")
    
    static let bitternessVariable = BrewVariable(id: 1, stepCount: 10, labelSet: bitternessLabelSet)
    
    static let tasteBundle = BrewVariableBundle(label: "Taste",
                                                        variables: [bitternessVariable,
                                                            BrewVariable(id: 2, stepCount: 10, labelSet: VariableLabelSet(mainLabel: "Flavour", minLabel: "Light", maxLabel: "Full"))])
    static let acidityBundle = BrewVariableBundle(label: "Acidity",
                                                          variables: [BrewVariable(id: 3, stepCount: 10, labelSet: VariableLabelSet(mainLabel: "Intensity", minLabel: "Minimal", maxLabel: "Intensive"))])
    
    static let bundles = [tasteBundle,
                          acidityBundle]
}

class BrewParametersTests: BaseTestCase {
    
    var brewVariableBundles: [BrewVariableBundle]!
    var values: [BrewVariable.Id: Double?]!
    
    var parameters: BrewParametersImpl!

    override func setUp() {
        super.setUp()
        
        brewVariableBundles = MockBrewVars.bundles
        
        values = [BrewVariable.Id: Double?]()
        values[brewVariableBundles[0].variables[0].id] = 0.8
        values[brewVariableBundles[1].variables[0].id] = 0.3
        
        parameters = BrewParametersImpl(brewVariableBundles: brewVariableBundles, values: values)
    }

    func testInit() {
        let allVariables = brewVariableBundles.flatMap { $0.variables }
        
        let brewParameters = BrewParametersImpl(brewVariableBundles: brewVariableBundles, values: values)
        
        for brewVariable in allVariables {
            let expectedValue = values[brewVariable.id] ?? BrewParametersImpl.defaultBrewValue
            
            XCTAssertEqual(expectedValue, brewParameters.valueMap[brewVariable.id])
        }
    }

}
