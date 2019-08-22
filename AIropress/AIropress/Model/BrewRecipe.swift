//
//  BrewRecipe.swift
//  AIropress
//
//  Created by Tomas Skypala on 16/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

struct BrewRecipe: Equatable {
    let constants: [RecipeConstant]
    let semiConstants: [RecipeSemiConstant]
}

class RecipeConstant {
    let id: Double
    let label: String
    
    let value: Double
    let valueText: String
    
    init(id: Double, label: String, value: Double, valueText: String) {
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

class RecipeSemiConstant: RecipeConstant {
    let confidenceVariable: BrewVariable
    var confidenceValue: Double
    
    init(id: Double, label: String, value: Double, valueText: String, confidenceVariable: BrewVariable, initialConfidenceValue: Double) {
        self.confidenceVariable = confidenceVariable
        self.confidenceValue = initialConfidenceValue
        
        super.init(id: id, label: label, value: value, valueText: valueText)
    }
}
