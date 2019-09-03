//
//  MainFlowController.swift
//  AIropress
//
//  Created by Tomas Skypala on 16/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

protocol BaseNavigationController {
    func push(viewController: UIViewController)
    func pop(animated: Bool)
}

protocol ViewControllerProvider {
    func getViewController(_ flowController: MainFlowController, for scene: Scene) -> UIViewController
}

class MainFlowController {
    
    let navigationController: BaseNavigationController
    let viewControllerProvider: ViewControllerProvider
    
    init(navigationController: BaseNavigationController, viewControllerProvider: ViewControllerProvider) {
        self.navigationController = navigationController
        self.viewControllerProvider = viewControllerProvider
    }
    
    func startFlow() {
        switchTo(scene: .desiredTaste)
    }
    
    func switchTo(scene: Scene) {
        let nextViewController = viewControllerProvider.getViewController(self, for: scene)
        navigationController.push(viewController: nextViewController)
    }
}

extension MainFlowController: DesiredTasteSceneFC {
    
    func onParametersSet(brewParameters: BrewParameters) {
        switchTo(scene: .aiProcessing(brewParameters: brewParameters))
    }
    
}

extension MainFlowController: AIProcessingSceneFC {
    
    func onProcessingDone(recipe: BrewRecipe) {
        navigationController.pop(animated: false)
        
        switchTo(scene: .viewRecipe(recipe: recipe))
    }
}

extension MainFlowController: ViewRecipeSceneFC {
    
    func onRecipeReset() {
        navigationController.pop(animated: true)
    }
    
    func onPrepared(recipeValues: [Int: Double]) {
        navigationController.pop(animated: false)
        
        guard let prepParams = PrepParams.create(values: recipeValues) else {
            fatalError("Insuficient recipeValues received.")
        }
        switchTo(scene: .brewPrep(params: prepParams))
    }

}

extension MainFlowController: BrewPrepSceneFC {
    
    func onBrewInitiated() {
        
    }

}
