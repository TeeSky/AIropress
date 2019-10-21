//
//  AeroPressFilterPlan.swift
//  AIropress
//
//  Created by Tomas Skypala on 17/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

struct AeroPressFilterPlan: BrewingPlan {

    static let pourDuration = 10.0
    static let stirDuration = 10.0
    static let capOnDuration = 10.0
    static let plungeDuration = 15.0

    static let bloomCoffeeAmountMultiplier = 2.0

    let orderedPhases: [BrewPhase]

    static func create(values: [Int: Double]) -> AeroPressFilterPlan? {
        return self.create(recipeValues: RecipeValue.createRecipeValueMap(from: values))
    }

    static func create(recipeValues: [RecipeValue: Double]) -> AeroPressFilterPlan? {
        guard let waterAmount = recipeValues[.waterAmount],
            let coffeeAmount = recipeValues[.coffeeAmount],
            let bloomDuration = recipeValues[.bloomDuration],
            let brewDuration = recipeValues[.brewDuration] else {
                return nil
        }

        return AeroPressFilterPlan(waterAmount: waterAmount, coffeeAmount: coffeeAmount,
                                   bloomDuration: bloomDuration, brewDuration: brewDuration)
    }

    init(waterAmount: Double, coffeeAmount: Double, bloomDuration: Double, brewDuration: Double) {
        let pourDuration = AeroPressFilterPlan.pourDuration
        let stirDuration = AeroPressFilterPlan.stirDuration
        let capOnDuration = AeroPressFilterPlan.capOnDuration
        let plungeDuration = AeroPressFilterPlan.plungeDuration

        let bloomWaterAmount = coffeeAmount * AeroPressFilterPlan.bloomCoffeeAmountMultiplier

        let nettoBrewDuration = brewDuration - pourDuration - stirDuration - capOnDuration

        orderedPhases = [
            BrewPhase(duration: pourDuration,
                      label: "Wet the coffee grounds with \(Int(bloomWaterAmount)) ml of water."),
            BrewPhase(duration: bloomDuration, label: "Wait, the coffee is blooming."),
            BrewPhase(duration: pourDuration,
                      label: "Pour the rest of the water reaching total of \(Int(waterAmount)) ml."),
            BrewPhase(duration: stirDuration, label: "Carefully and slowly stir 3-4 times."),
            BrewPhase(duration: nettoBrewDuration, label: "Wait, the coffee is brewing."),
            BrewPhase(duration: capOnDuration, label: "Screw on the filter and place the Aeropress on the mug."),
            BrewPhase(duration: plungeDuration, label: "Plunge slowly until you hear hissing sound.")
        ]
    }
}
