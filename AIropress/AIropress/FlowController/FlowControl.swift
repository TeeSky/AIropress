//
//  FlowControl.swift
//  AIropress
//
//  Created by Tomas Skypala on 16/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

protocol DesiredTasteSceneFC: AnyObject {
    func onParametersSet(brewParameters: BrewParameters)
}

protocol AIProcessingSceneFC: AnyObject {
    func onProcessingDone(recipe: BrewRecipe)
}

protocol ViewRecipeSceneFC: AnyObject {
    func onViewRecipeReset()
    func onPrepared(recipeValues: [Int: Double])
}

protocol BrewPrepSceneFC: AnyObject {
    func onBrewPrepReset()
    func onBrewInitiated()
}

protocol BrewingSceneFC: AnyObject {
    func onBrewStopped()
    func onBrewFinished()
}

protocol BrewDoneSceneFC: AnyObject {
    func onMakeAnother()
}
