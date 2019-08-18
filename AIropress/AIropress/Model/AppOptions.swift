//
//  File.swift
//  AIropress
//
//  Created by Tomas Skypala on 18/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

struct AppOptions {
    
    static let brewVariableBundles = AppBrewVariableBundles().bundles
    
    private init() {}
}


struct AppBrewVariableBundles {
    
    static let defaultStepCount = 10
    
    let bundles: [BrewVariableBundle]
    
    fileprivate init() {
        
        let tasteBundle = BrewVariableBundle(label: "Taste",
                                             variables: [BrewVariable(id: 1, stepCount: AppBrewVariableBundles.defaultStepCount,
                                                                      labelSet: VariableLabelSet(mainLabel: "Bitterness", minLabel: "Watery", maxLabel: "Bitter")),
                                                         BrewVariable(id: 2, stepCount: AppBrewVariableBundles.defaultStepCount,
                                                                      labelSet: VariableLabelSet(mainLabel: "Flavour", minLabel: "Light", maxLabel: "Full"))])
        let acidityBundle = BrewVariableBundle(label: "Acidity",
                                               variables: [BrewVariable(id: 3, stepCount: AppBrewVariableBundles.defaultStepCount,
                                                                        labelSet: VariableLabelSet(mainLabel: "Intensity", minLabel: "Minimal", maxLabel: "Intensive"))])
        
        self.bundles = [tasteBundle,
                       acidityBundle]
    }
}
