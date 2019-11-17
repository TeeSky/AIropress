//
//  BrewDoneViewController.swift
//  AIropress
//
//  Created by Tomas Skypala on 13/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

class BrewDoneViewController: BaseViewController<BrewDoneSceneView> {

    var viewModel: BrewDoneVM!

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.makeAnotherButton.addTarget(
            viewModel,
            action: #selector(viewModel.onMakeAnotherClicked),
            for: .touchUpInside
        )
    }
}
