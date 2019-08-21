//
//  AIProcessingVM.swift
//  AIropress
//
//  Created by Tomas Skypala on 21/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

protocol AIProcessingVMDelegate: class {
    func setProgressLabel(text: String)
    func setActivityIndicatorState(animating: Bool)
}

class AIProcessingVM: BaseViewModel {
    
    weak var flowController: AIProcessingSceneFC?
    weak var delegate: AIProcessingVMDelegate?
    
    let brewParameters: BrewParameters
    
    init(brewParameters: BrewParameters) {
        self.brewParameters = brewParameters
        
        startProcessing()
    }
    
    func onViewDidLoad() {
        delegate?.setActivityIndicatorState(animating: true)
        delegate?.setProgressLabel(text: "Processing...")
    }
    
    func onSceneDidAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { // Mock code, replace with processing done check.
            self.onProcessingDone(recipe: BrewRecipe())
        }
    }
    
    private func startProcessing() {
        // TODO
    }
    
    private func onProcessingDone(recipe: BrewRecipe) {
        delegate?.setActivityIndicatorState(animating: false)
        delegate?.setProgressLabel(text: "Processing done.")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.flowController?.onProcessingDone(recipe: recipe)
        }
    }
}
