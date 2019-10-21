//
//  PrismoEspressoPlan.swift
//  AIropress
//
//  Created by Tomáš Skýpala on 22/10/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

struct PrismoEspressoPlan: BrewingPlan {

    static let pourDuration = 10.0
    static let stirDuration = 40.0
    static let capOnDuration = 10.0
    static let plungeDuration = 10.0

    let orderedPhases: [BrewPhase]

    static func create(values: [Int: Double]) -> PrismoEspressoPlan? {
        return self.create(recipeValues: RecipeValue.createRecipeValueMap(from: values))
    }

    static func create(recipeValues: [RecipeValue: Double]) -> PrismoEspressoPlan? {
        guard let waterAmount = recipeValues[.waterAmount],
            let coffeeAmount = recipeValues[.coffeeAmount],
            let brewDuration = recipeValues[.brewDuration] else {
                return nil
        }

        return PrismoEspressoPlan(waterAmount: waterAmount, coffeeAmount: coffeeAmount, brewDuration: brewDuration)
    }

    init(waterAmount: Double, coffeeAmount: Double, brewDuration: Double) {
        let pourDuration = PrismoEspressoPlan.pourDuration
        let capOnDuration = PrismoEspressoPlan.capOnDuration
        let plungeDuration = PrismoEspressoPlan.plungeDuration

        let stiringBrewDuration = brewDuration - pourDuration - capOnDuration

        orderedPhases = [
            BrewPhase(duration: pourDuration,
                      label: "Pour in all of \(Int(waterAmount)) ml freshly boiled water."),
            BrewPhase(duration: stiringBrewDuration, label: "Vigorously stir the water & coffee grounds mixture."),
            BrewPhase(duration: capOnDuration, label: "Screw on the Prismo filter and place the Aeropress on the mug."),
            BrewPhase(duration: plungeDuration, label: "Plunge all the way.")
        ]
    }
}
