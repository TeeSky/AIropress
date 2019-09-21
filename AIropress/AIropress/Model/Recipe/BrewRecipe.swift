//
//  BrewRecipe.swift
//  AIropress
//
//  Created by Tomas Skypala on 16/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

struct BrewRecipe: Equatable, Codable {
    let constants: [RecipeConstant]
    let semiConstants: [RecipeSemiConstant]
    
    init(constants: [RecipeConstant], semiConstants: [RecipeSemiConstant]) {
        self.constants = constants
        self.semiConstants = semiConstants
    }
    
    static func createDefaultFilterRecipe(bundle: Bundle = Bundle.main) -> BrewRecipe {
        let decoder = JSONDecoder()
        let asset = NSDataAsset(name: "DefaultFilterRecipe", bundle: bundle)
        return try! decoder.decode(BrewRecipe.self, from: asset!.data)
    }
}

//let constants: [RecipeConstant] = [RecipeConstant(id: RecipeValue.waterAmount.rawValue, value: 85),
//                                   RecipeConstant(id: RecipeValue.totalBrewDuration.rawValue, value: 95),
//                                   RecipeConstant(id: RecipeValue.brewDuration.rawValue, value: 30),
//                                   RecipeConstant(id: RecipeValue.bloomDuration.rawValue, value: 20),
//                                   RecipeConstant(id: RecipeValue.coffeeAmount.rawValue, value: 13),
//                                   RecipeConstant(id: RecipeValue.aeropressOrientation.rawValue, value: AeropressBrewOrientation.inverted.value())]
//
//let semiConstants: [RecipeSemiConstant] = [RecipeSemiConstant(id: RecipeValue.temperature.rawValue, value: 86, confidenceVariableId: 10, initialConfidenceValue: 0.8),
//                                           RecipeSemiConstant(id: RecipeValue.grindSize.rawValue, value: 28, confidenceVariableId: 11, initialConfidenceValue: 0.5)]
