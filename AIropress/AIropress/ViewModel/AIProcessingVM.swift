//
//  AIProcessingVM.swift
//  AIropress
//
//  Created by Tomas Skypala on 21/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

protocol AIProcessingVMDelegate: class {
    func onProcessingDone()
}

class AIProcessingVM: BaseViewModel {
    
    weak var flowController: AIProcessingSceneFC?
    weak var delegate: AIProcessingVMDelegate?
    
    let brewParameters: BrewParameters
    
    init(brewParameters: BrewParameters) {
        self.brewParameters = brewParameters
        
        startProcessing()
    }
    
    func onSceneDidAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Mock code, replace with processing done check.
            self.onProcessingDone(recipe: BrewRecipe())
        }
    }
    
    private func startProcessing() {
        // TODO
    }
    
    private func onProcessingDone(recipe: BrewRecipe) {
        delegate?.onProcessingDone()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.flowController?.onProcessingDone(recipe: recipe)
        }
    }
}
