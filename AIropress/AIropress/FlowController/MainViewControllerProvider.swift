//
//  ViewControllerProvider.swift
//  AIropress
//
//  Created by Tomas Skypala on 18/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

struct MainViewControllerProvider: ViewControllerProvider {
    
    
    func getViewController(_ flowController: MainFlowController, for scene: Scene) -> UIViewController {
        let controller: UIViewController
        switch scene {
        case .desiredTaste:
            let desiredTasteVM = DesiredTasteVM(brewVariableBundles: AppOptions.brewVariableBundles)
            desiredTasteVM.flowController = flowController
            let desiredTasteViewController = DesiredTasteViewController()
            desiredTasteViewController.viewModel = desiredTasteVM
            controller = desiredTasteViewController
        case .aiProcessing(let brewParameters):
            let aiProcessingVM = AIProcessingVM(brewParameters: brewParameters)
            aiProcessingVM.flowController = flowController
            let aiProcessingViewController = AIProcessingViewController()
            aiProcessingViewController.viewModel = aiProcessingVM
            controller = aiProcessingViewController
        case .viewRecipe(let recipe):
            let viewRecipeVM = ViewRecipeVM(brewRecipe: recipe)
            viewRecipeVM.flowController = flowController
            let viewRecipeViewController = ViewRecipeViewController()
            viewRecipeViewController.viewModel = viewRecipeVM
            controller = viewRecipeViewController
        case .brewPrep(let prepParams):
            let brewPrepVM = BrewPrepVM(prepParams: prepParams)
            brewPrepVM.flowController = flowController
            let brewPrepViewController = BrewPrepViewController()
            brewPrepViewController.viewModel = brewPrepVM
            controller = brewPrepViewController
        case .brewing(let brewPhases):
            let brewingVM = BrewingVM(brewPhases: brewPhases)
            brewingVM.flowController = flowController
            let brewingViewController = BrewingViewController()
            brewingViewController.viewModel = brewingVM
            controller = brewingViewController
        case .allDone:
            let allDoneVM = AllDoneVM()
            allDoneVM.flowController = flowController
            let allDoneViewController = AllDoneViewController()
            allDoneViewController.viewModel = allDoneVM
            controller = allDoneViewController
//        default:
//            fatalError("not implemented")
        }
        return controller
    }
    
}
