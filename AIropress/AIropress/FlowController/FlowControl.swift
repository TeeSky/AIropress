//
//  FlowControl.swift
//  AIropress
//
//  Created by Tomas Skypala on 16/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

protocol DesiredTasteSceneFC: class {
    func onParametersSet(brewParameters: BrewParameters)
}

protocol AIProcessingSceneFC: class {
    func onProcessingDone(recipe: BrewRecipe)
}

protocol ViewRecipeSceneFC: class {
    func onRecipeReset()
    func onPrepared(recipeValues: [Int: Double])
}

protocol BrewPrepSceneFC: class {
    func onRecipeReset()
    func onBrewInitiated()
}

protocol BrewingSceneFC: class {
    func onRecipeReset()
    func onBrewFinished()
}

protocol AllDoneSceneFC: class {
    func onMakeAnother()
}
