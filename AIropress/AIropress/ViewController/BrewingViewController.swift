//
//  BrewingViewController.swift
//  AIropress
//
//  Created by Tomas Skypala on 13/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

class BrewingViewController: BaseViewController<BrewingSceneView> {
    
    var viewModel: BrewingVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.onSceneDidAppear()
    }
}

extension BrewingViewController: BrewingVMDelegate {
    
    
    func setTimerTexts(mainTimerText: String, currentPhaseTimerText: String?) {
        sceneView.mainTimerLabel.text = mainTimerText
        if let currentPhaseTimerText = currentPhaseTimerText {
            sceneView.currentPhaseTimerLabel.timerLabel.text = currentPhaseTimerText
        }
    }
    
    func setPhaseTexts(textSets: [PhaseTextSet]) {
        sceneView.currentPhaseTimerLabel.configure(with: textSets[safe: 0])
        sceneView.next1TimerLabel.configure(with: textSets[safe: 1])
        sceneView.next2TimerLabel.configure(with: textSets[safe: 2])
    }
    
}
