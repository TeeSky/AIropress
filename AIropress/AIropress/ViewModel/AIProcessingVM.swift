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
            let constants: [RecipeConstant] = [RecipeConstant(id: 0, label: "Water", value: 85, valueText: "85ml"),
                                               RecipeConstant(id: 1, label: "Brewing time", value: 90, valueText: "1:30"),
                                               RecipeConstant(id: 2, label: "Coffee", value: 13, valueText: "13g")]
            
            let semiConstants: [RecipeSemiConstant] = [RecipeSemiConstant(id: 3, label: "Temperature", value: 86, valueText: "86C", confidenceVariableId: 10, initialConfidenceValue: 0.8),
                                                       RecipeSemiConstant(id: 4, label: "Grind size", value: 28, valueText: "coarse", confidenceVariableId: 11, initialConfidenceValue: 0.5)]
            
            
            self.onProcessingDone(recipe: BrewRecipe(constants: constants, semiConstants: semiConstants))
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
