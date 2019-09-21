//
//  PrepParams.swift
//  AIropress
//
//  Created by Tomas Skypala on 30/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

struct PrepParams {
    let prepSteps: [PrepStep]

    static func create(values: [Int: Double]) -> PrepParams? {
        return self.create(recipeValues: RecipeValue.createRecipeValueMap(from: values))
    }

    static func create(recipeValues: [RecipeValue: Double]) -> PrepParams? {
        guard let tempValue = recipeValues[.temperature],
            let coffeeAmount = recipeValues[.coffeeAmount],
            let orientationValue = recipeValues[.aeropressOrientation],
            let aeropressOrientation = AeropressBrewOrientation.fromDouble(value: orientationValue) else {
                return nil
        }

        return PrepParams(waterTemp: tempValue, coffeeAmount: coffeeAmount, aeropressOrientation: aeropressOrientation)
    }

    init(waterTemp: Double, coffeeAmount: Double, aeropressOrientation: AeropressBrewOrientation) {
        prepSteps = [.preheatWater(waterTemp.toTempString()),
        .rinseFilter,
        .rinseAeropress,
        .orientate(aeropressOrientation),
        .placeOnScale,
        .weighOutCoffee(coffeeAmount.toWeightString()),
        .prepareKettle]
    }

}
