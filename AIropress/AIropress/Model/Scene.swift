//
//  Scene.swift
//  AIropress
//
//  Created by Tomas Skypala on 16/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

enum Scene {
    case desiredTaste
    case aiProcessing(brewParameters: BrewParameters)
    case viewRecipe(recipe: BrewRecipe)
    case brewPrep(params: PrepParams)
    case brewing(brewPhases: [BrewPhase])
    case allDone
}
