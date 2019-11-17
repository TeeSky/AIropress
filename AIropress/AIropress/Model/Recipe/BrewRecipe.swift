//
//  BrewRecipe.swift
//  AIropress
//
//  Created by Tomas Skypala on 16/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

struct BrewRecipe: Equatable {
    let constants: [RecipeConstant]
    let semiConstants: [RecipeSemiConstant]

    init(constants: [RecipeConstant], semiConstants: [RecipeSemiConstant]) {
        self.constants = constants
        self.semiConstants = semiConstants
    }

    static func createDefaultFilterRecipe(bundle: Bundle = Bundle.main) -> BrewRecipe {
        let decoder = JSONDecoder()
        let asset = NSDataAsset(name: "DefaultFilterRecipe", bundle: bundle)

        guard let recipe = try? decoder.decode(BrewRecipe.self, from: asset!.data) as BrewRecipe else {
            fatalError("Could not decode the default filer BrewRecipe. Make sure there is " +
                "a proper \"DefaultFilterRecipe\" data asset available.")
        }
        return recipe
    }

    static func createDefaultPrismoEspressoRecipe(bundle: Bundle = Bundle.main) -> BrewRecipe {
        let decoder = JSONDecoder()
        let asset = NSDataAsset(name: "DefaultPrismoEspressoRecipe", bundle: bundle)

        guard let recipe = try? decoder.decode(BrewRecipe.self, from: asset!.data) as BrewRecipe else {
            fatalError("Could not decode the default prismo espresso BrewRecipe. Make sure there is " +
                "a proper \"DefaultPrismoEspressoRecipe\" data asset available.")
        }
        return recipe
    }
}

extension BrewRecipe: FSObject {
    static var collectionId: String { "brew-recipes" }
}
