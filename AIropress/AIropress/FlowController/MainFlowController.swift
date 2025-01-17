//
//  MainFlowController.swift
//  AIropress
//
//  Created by Tomas Skypala on 16/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

enum LaunchMode {
    case normal
    case brewShortcut(BrewRecipe)
}

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

    func startFlow(launchMode: LaunchMode = .normal) {
        switch launchMode {
        case .normal:
            switchTo(scene: .desiredTaste)
        case .brewShortcut(let recipe):
            skipToViewRecipe(recipe)
        }
    }

    func switchTo(scene: Scene) {
        let nextViewController = viewControllerProvider.getViewController(self, for: scene)
        navigationController.push(viewController: nextViewController)
    }

    private func skipToViewRecipe(_ recipe: BrewRecipe) {
        let initialViewController = viewControllerProvider.getViewController(self, for: .desiredTaste)
        navigationController.push(viewController: initialViewController)

        switchTo(scene: .viewRecipe(recipe: recipe))
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

        guard let values = recipeValues else {
           fatalError("Nil or insuficient recipeValues obtained.")
       }
        let recipeValues = RecipeValue.createRecipeValueMap(from: values)
        let brewTypeValue = recipeValues[.brewType]

        let phases: [BrewPhase]?
        switch brewTypeValue {
        case 1:
            phases = PrismoEspressoPlan.create(recipeValues: recipeValues)?.orderedPhases
        default:
            phases = AeroPressFilterPlan.create(recipeValues: recipeValues)?.orderedPhases
        }

        guard let brewPhases = phases else {
            fatalError("Nil or insuficient recipeValues obtained.")
        }
        switchTo(scene: .brewing(brewPhases: brewPhases))
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
