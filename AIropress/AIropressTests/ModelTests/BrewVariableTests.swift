//
//  BrewVariableTests.swift
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
    
    
    static let constants: [RecipeConstant] = [RecipeConstant(id: 0, label: "Water", value: 85, valueText: "85ml"),
                                       RecipeConstant(id: 1, label: "Brewing time", value: 90, valueText: "1:30"),
                                       RecipeConstant(id: 2, label: "Coffee", value: 13, valueText: "13g")]
    
    static let confidenceLabelSet = VariableLabelSet(mainLabel: "Confidence", minLabel: "Unconfident", maxLabel: "Confident")
    static let temperatureConfidence = BrewVariable(id: 10, stepCount: 5, labelSet: confidenceLabelSet)
    static let grindSizeConfidence = BrewVariable(id: 11, stepCount: 5, labelSet: confidenceLabelSet)
    static let semiConstants: [RecipeSemiConstant] = [RecipeSemiConstant(id: 3, label: "Temperature", value: 86, valueText: "86C", confidenceVariable: temperatureConfidence, initialConfidenceValue: 0.8),
                                               RecipeSemiConstant(id: 4, label: "Grind size", value: 28, valueText: "coarse", confidenceVariable: grindSizeConfidence, initialConfidenceValue: 0.5)]
    
    static let recipe: BrewRecipe = BrewRecipe(constants: constants, semiConstants: semiConstants)
}

class BrewVariableTests: XCTestCase {
    
    private var brewVariable: BrewVariable!

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
