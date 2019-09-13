//
//  BrewPhase.swift
//  AIropress
//
//  Created by Tomas Skypala on 10/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

struct BrewPhase: Equatable {
    let duration: Double
    let label: String
}

protocol BrewingPlan {
    var orderedPhases: [BrewPhase] { get }
}

struct AeroPressBrewingPlan: BrewingPlan {
    
    static let pourDuration = 10.0
    static let stirDuration = 10.0
    static let plungeDuration = 15.0
    
    static let bloomCoffeeAmountMultiplier = 2.0
    
    let orderedPhases: [BrewPhase]
    
    static func create(values: [Int: Double]) -> AeroPressBrewingPlan? {
        return self.create(recipeValues: RecipeValueId.createRecipeValueMap(from: values))
    }
    
    static func create(recipeValues: [RecipeValueId: Double]) -> AeroPressBrewingPlan? {
        guard let waterAmount = recipeValues[.waterAmount],
            let coffeeAmount = recipeValues[.coffeeAmount],
            let bloomDuration = recipeValues[.bloomDuration],
            let brewDuration = recipeValues[.brewDuration] else {
                return nil
        }
        
        return AeroPressBrewingPlan(waterAmount: waterAmount, coffeeAmount: coffeeAmount,
                                    bloomDuration: bloomDuration, brewDuration: brewDuration)
    }
    
    init(waterAmount: Double, coffeeAmount: Double, bloomDuration: Double, brewDuration: Double) {
        let pourDuration = AeroPressBrewingPlan.pourDuration
        let stirDuration = AeroPressBrewingPlan.stirDuration
        let plungeDuration = AeroPressBrewingPlan.plungeDuration
        
        let bloomWaterAmount = coffeeAmount * AeroPressBrewingPlan.bloomCoffeeAmountMultiplier
        
        orderedPhases = [
            BrewPhase(duration: pourDuration, label: "Wet the coffee grounds with \(Int(bloomWaterAmount)) ml of water."),
            BrewPhase(duration: bloomDuration, label: "Wait, the coffee is blooming."),
            BrewPhase(duration: pourDuration, label: "Pour the rest of the water reaching total of \(Int(waterAmount)) ml."),
            BrewPhase(duration: stirDuration, label: "Carefully and slowly stir 3-4 times."),
            BrewPhase(duration: brewDuration, label: "Wait, the coffee is brewing."),
            BrewPhase(duration: plungeDuration, label: "Plunge until you hear hissing sound."),
        ]
    }
}
