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
    
    
    static let constants: [RecipeConstant] = [RecipeConstant(id: RecipeValue.waterAmount.rawValue, value: 85),
                                       RecipeConstant(id: RecipeValue.totalBrewDuration.rawValue, value: 90),
                                       RecipeConstant(id: RecipeValue.coffeeAmount.rawValue, value: 13)]
    
    static let semiConstants: [RecipeSemiConstant] = [RecipeSemiConstant(id: RecipeValue.temperature.rawValue, value: 86, confidenceVariableId: 10, initialConfidenceValue: 0.8),
                                               RecipeSemiConstant(id: RecipeValue.grindSize.rawValue, value: 28, confidenceVariableId: 11, initialConfidenceValue: 0.5)]
    
    static let recipe: BrewRecipe = BrewRecipe(constants: constants, semiConstants: semiConstants)
    
    static let recipeValues: [Int: Double] = [RecipeValue.aeropressOrientation.rawValue: AeropressBrewOrientation.inverted.value(),
                                              RecipeValue.coffeeAmount.rawValue: 13.0,
                                              RecipeValue.temperature.rawValue: 85.0,
                                              RecipeValue.waterAmount.rawValue: 90.0,
                                              RecipeValue.bloomDuration.rawValue: 20.0,
                                              RecipeValue.brewDuration.rawValue: 35.0]
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
