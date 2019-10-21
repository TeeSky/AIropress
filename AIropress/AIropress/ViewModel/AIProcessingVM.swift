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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Mock code, replace with processing done check.
            let recipe = BrewRecipe.createDefaultFilterRecipe(bundle: Bundle(for: type(of: self)))

            self.onProcessingDone(recipe: recipe)
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
