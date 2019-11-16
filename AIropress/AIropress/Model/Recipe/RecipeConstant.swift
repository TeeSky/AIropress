//
//  RecipeConstant.swift
//  AIropress
//
//  Created by Tomas Skypala on 17/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

class RecipeConstant: Codable {

    var value: Double {
        return val
    }

    let id: Int
    private let val: Double

    lazy var stringifier: ValueStringifier? = {
        guard let recipeValue = RecipeValue(rawValue: id) else {
            return nil
        }
        return recipeValue.stringifier()
    }()

    init(id: Int, value: Double) {
        self.id = id
        val = value
    }
}

extension RecipeConstant: Equatable {

    static func == (lhs: RecipeConstant, rhs: RecipeConstant) -> Bool {
        return lhs.id == rhs.id
    }
}

class RecipeSemiConstant: Codable {

    var constant: RecipeConstant {
        return const
    }

    var confidenceId: Int {
        return confId
    }

    var confidenceValue: Double {
        return confVal
    }

    lazy var confidenceVariable: BrewVariable = {
        BrewVariable.createConfidenceVariable(id: confidenceId)
    }()

    private let const: RecipeConstant
    private let confId: Int

    private var confVal: Double

    init(id: Int, value: Double, confidenceVariableId: BrewVariable.Id, initialConfidenceValue: Double) {
        const = RecipeConstant(id: id, value: value)

        confId = confidenceVariableId
        confVal = initialConfidenceValue
    }
}

extension RecipeSemiConstant: Equatable {

    static func == (lhs: RecipeSemiConstant, rhs: RecipeSemiConstant) -> Bool {
        return lhs.constant.id == rhs.constant.id
    }
}
