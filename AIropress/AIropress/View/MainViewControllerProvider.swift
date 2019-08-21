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
        default:
            fatalError("not implemented")
        }
        return controller
    }
    
    
}
