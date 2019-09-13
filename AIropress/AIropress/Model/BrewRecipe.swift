//
//  BrewRecipe.swift
//  AIropress
//
//  Created by Tomas Skypala on 16/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

protocol BrewRecipeProvider {
    func createRecipe(recipeValues: [Int: Double]) -> BrewRecipe
}

struct BrewRecipe: Equatable {
    let constants: [RecipeConstant]
    let semiConstants: [RecipeSemiConstant]
    
    init() { // Mock init, remove and instantiate using real calculated values
        let constants: [RecipeConstant] = [RecipeConstant(id: RecipeValueId.waterAmount.rawValue, label: "Water", value: 85, valueText: "85ml"),
                                           RecipeConstant(id: RecipeValueId.brewDuration.rawValue, label: "Brewing time", value: 30, valueText: "1:35s"), // TODO fix time addition
                                           RecipeConstant(id: RecipeValueId.bloomDuration.rawValue, label: "Bloom time", value: 20, valueText: "0:20s"),
                                           RecipeConstant(id: RecipeValueId.coffeeAmount.rawValue, label: "Coffee", value: 13, valueText: "13g"),
                                           RecipeConstant(id: RecipeValueId.aeropressOrientation.rawValue, label: "Aer. orientation",
                                                          value: AeropressBrewOrientation.inverted.value(), valueText: AeropressBrewOrientation.inverted.valueText())]
        
        let semiConstants: [RecipeSemiConstant] = [RecipeSemiConstant(id: RecipeValueId.temperature.rawValue, label: "Temperature", value: 86, valueText: "86C", confidenceVariableId: 10, initialConfidenceValue: 0.8),
                                                   RecipeSemiConstant(id: 4, label: "Grind size", value: 28, valueText: "coarse", confidenceVariableId: 11, initialConfidenceValue: 0.5)]
        
        
        self.init(constants: constants, semiConstants: semiConstants)
    }
    
    init(constants: [RecipeConstant], semiConstants: [RecipeSemiConstant]) {
        self.constants = constants
        self.semiConstants = semiConstants
    }
}

enum RecipeValueId: Int {
    case aeropressOrientation = 100
    case temperature = 101
    case grindSize = 102
    case coffeeAmount = 103
    case waterAmount = 104
    
    case bloomDuration = 200
    case brewDuration = 201
    
    
    static func createRecipeValueMap(from valueMap: [Int: Double]) -> [RecipeValueId: Double] {
        var recipeValueMap: [RecipeValueId: Double] = [:]
        
        for (id, value) in valueMap {
            if let recipeValueId = RecipeValueId.init(rawValue: id) {
                recipeValueMap[recipeValueId] = value
            }
        }
        return recipeValueMap
    }
}

struct RecipeConstant {
    let id: Int
    let label: String
    
    let value: Double
    let valueText: String
    
    init(id: Int, label: String, value: Double, valueText: String) {
        self.id = id
        self.label = label
        self.value = value
        self.valueText = valueText
    }
}

extension RecipeConstant: Equatable {
    
    static func == (lhs: RecipeConstant, rhs: RecipeConstant) -> Bool {
        return lhs.id == rhs.id
    }
    
}

struct RecipeSemiConstant {
    let constant: RecipeConstant
    let confidenceVariable: BrewVariable
    var confidenceValue: Double
    
    init(id: Int, label: String, value: Double, valueText: String, confidenceVariableId: BrewVariable.Id, initialConfidenceValue: Double) {
        self.constant = RecipeConstant(id: id, label: label, value: value, valueText: valueText)
        
        self.confidenceVariable = BrewVariable.createConfidenceVariable(id: confidenceVariableId)
        self.confidenceValue = initialConfidenceValue
    }
}

extension RecipeSemiConstant: Equatable {
    
    static func == (lhs: RecipeSemiConstant, rhs: RecipeSemiConstant) -> Bool {
        return lhs.constant.id == rhs.constant.id
    }
}
