//
//  AIProcessingViewController.swift
//  AIropress
//
//  Created by Tomas Skypala on 21/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

class AIProcessingViewController: BaseViewController<AIProcessingSceneView> {

    var viewModel: AIProcessingVM!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.onViewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.onSceneDidAppear()
    }
}

extension AIProcessingViewController: AIProcessingVMDelegate {

    func setProgressLabel(text: String) {
        let label = sceneView.progressLabel

        label.fadeTransition(0.75)
        label.text = text
    }

    func setActivityIndicatorState(animating: Bool) {
        let indicator = sceneView.activityIndicator
        let shouldHide: Bool
        if animating {
            indicator.startAnimating()
            shouldHide = false
        } else {
            shouldHide = true
        }

        setActivityIndicatorHiddenAnimated(hidden: shouldHide)
    }

    private func setActivityIndicatorHiddenAnimated(hidden: Bool) {
        let animations = { [weak self] () -> Void in
            self?.sceneView.activityIndicator.alpha = hidden ? 0.0 : 1.0
        }

        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: animations) { [weak self] _ in
            guard let self = self else { return }

            let indicator = self.sceneView.activityIndicator
            indicator.isHidden = hidden

            if hidden {
                indicator.stopAnimating()
            }
        }
    }
}
