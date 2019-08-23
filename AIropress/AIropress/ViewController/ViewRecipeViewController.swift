//
//  ViewRecipeViewController.swift
//  AIropress
//
//  Created by Tomas Skypala on 23/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

class ViewRecipeViewController: BaseViewController<ViewRecipeSceneView> {
    
    var viewModel: ViewRecipeVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.configure(tableView: sceneView.tableView)
        
        sceneView.resetButton.addTarget(viewModel, action: #selector(viewModel.onResetClicked), for: .touchUpInside)
        sceneView.prepareButton.addTarget(viewModel, action: #selector(viewModel.onPrepareClicked), for: .touchUpInside)
    }
}
