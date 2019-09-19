//
//  RecipeConstant.swift
//  AIropress
//
//  Created by Tomas Skypala on 17/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

struct RecipeConstant {
    let id: Int
    let value: Double
    
    let stringifier: ValueStringifier?
    
    init(id: Int, value: Double) {
        self.id = id
        self.value = value
        
        guard let recipeValue = RecipeValue(rawValue: id) else {
            self.stringifier = nil
            return
        }
        self.stringifier = recipeValue.stringifier()
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
    
    init(id: Int, value: Double, confidenceVariableId: BrewVariable.Id, initialConfidenceValue: Double) {
        self.constant = RecipeConstant(id: id, value: value)
        
        self.confidenceVariable = BrewVariable.createConfidenceVariable(id: confidenceVariableId)
        self.confidenceValue = initialConfidenceValue
    }
}

extension RecipeSemiConstant: Equatable {
    
    static func == (lhs: RecipeSemiConstant, rhs: RecipeSemiConstant) -> Bool {
        return lhs.constant.id == rhs.constant.id
    }
}
