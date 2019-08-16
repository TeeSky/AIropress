//
//  FlowControl.swift
//  AIropress
//
//  Created by Skypy on 16/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

protocol DesiredTasteSceneFC {
    func onParametersSet(brewParameters: BrewParameters)
}

protocol AIProcessingSceneFC {
    func onProcessingDone(recipe: BrewRecipe)
}

protocol ViewRecipeSceneFC {
    func onRecipeReset()
    func onPrepared(recipe: BrewRecipe)
}
