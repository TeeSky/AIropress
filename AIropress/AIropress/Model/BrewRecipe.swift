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
