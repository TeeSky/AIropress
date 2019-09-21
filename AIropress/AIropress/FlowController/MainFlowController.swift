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

    var recipeValues: [Int: Double]?

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

    func onViewRecipeReset() {
        navigationController.pop(animated: true)
    }

    func onPrepared(recipeValues: [Int: Double]) {
        self.recipeValues = recipeValues
        guard let prepParams = PrepParams.create(values: recipeValues) else {
            fatalError("Insuficient recipeValues obtained.")
        }
        switchTo(scene: .brewPrep(params: prepParams))
    }

}

extension MainFlowController: BrewPrepSceneFC {

    func onBrewPrepReset() {
        navigationController.pop(animated: false)
        navigationController.pop(animated: true)
    }

    func onBrewInitiated() {
        navigationController.pop(animated: false)
        guard let brewingPlan = AeroPressFilterPlan.create(values: recipeValues ?? [:]) else {
            fatalError("Nil or insuficient recipeValues obtained.")
        }

        switchTo(scene: .brewing(brewPhases: brewingPlan.orderedPhases))
    }

}

extension MainFlowController: BrewingSceneFC {

    func onBrewStopped() {
        navigationController.pop(animated: true)
    }

    func onBrewFinished() {
        navigationController.pop(animated: false)
        navigationController.pop(animated: false)

        switchTo(scene: .allDone)
    }

}

extension MainFlowController: AllDoneSceneFC {

    func onMakeAnother() {
        navigationController.pop(animated: true)
    }

}
