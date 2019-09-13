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
    
    
    func setTimerTexts(mainTimerText: String, currentPhaseTimerText: String) {
        sceneView.mainTimerLabel.text = mainTimerText
        sceneView.currentPhaseTimerLabel.timerLabel.text = currentPhaseTimerText
    }
    
    func setPhaseTexts(textSets: [PhaseTextSet]) {
        guard textSets.count == 3 else { fatalError("textSets must contain exactly 3 PhaseTextSets.") }
        
        sceneView.currentPhaseTimerLabel.configure(with: textSets[0])
        sceneView.next1TimerLabel.configure(with: textSets[1])
        sceneView.next2TimerLabel.configure(with: textSets[2])
    }
    
}
