//
//  File.swift
//  AIropress
//
//  Created by Tomas Skypala on 18/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

struct AppOptions {
    
    static let brewVariableBundles = AppBrewVariableBundles().bundles
    static let color = AppColor()
    static let fontSize = AppFontSize()
    
    private init() {}
}

struct AppBrewVariableBundles {
    
    static let defaultStepCount = 11 // 10 + zero
    
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

struct AppColor {
    
    let button =  UIColor(red: 62/255, green: 39/255, blue: 35/255, alpha: 1)
    let buttonPositive =  UIColor(red: 76/255, green: 175/255, blue: 80/255, alpha: 1)
    let buttonNegative =  UIColor(red: 211/255, green: 47/255, blue: 47/255, alpha: 1)
    
    fileprivate init() {
    }
}

struct AppFontSize {
    
    let xlarge: CGFloat = 35
    let large: CGFloat = 25
    let normal: CGFloat = 20
    let small: CGFloat = 17
    let tiny: CGFloat = 12
    
    fileprivate init() {
    }
}
