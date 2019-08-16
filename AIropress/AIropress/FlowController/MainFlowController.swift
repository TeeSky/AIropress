//
//  MainFlowController.swift
//  AIropress
//
//  Created by Skypy on 16/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit


protocol BaseNavigationController {
    func push(viewController: UIViewController)
    func pop()
}

protocol ViewControllerProvider {
    func getViewController(for scene: Scene) -> UIViewController
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
        let nextViewController = viewControllerProvider.getViewController(for: scene)
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
        navigationController.pop()
        
        switchTo(scene: .viewRecipe(recipe: recipe))
    }
}

extension MainFlowController: ViewRecipeSceneFC {
    
    func onRecipeReset() {
        navigationController.pop()
    }
    
    func onPrepared(recipe: BrewRecipe) {
        fatalError("not implemented")
    }
}
