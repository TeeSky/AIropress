//
//  BrewVariableBundleCell.swift
//  AIropress
//
//  Created by Tomas Skypala on 19/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

class BrewVariableBundleCell: UITableViewCell {
    
    var viewModel: BrewVariableBundleCellVM! {
        didSet {
            let variableBundle = viewModel.variableBundle
            label.text = variableBundle.label
            
            sliders = []
            for variable in variableBundle.variables {
                let slider = DiscreteSlider()
                slider.stepCount = variable.stepCount
                slider.delegate = BrewVariableSliderDelegate(brewVariable: variable,
                                                             onChange: viewModel.onSliderValueChanged(brewVariable:valueIndex:))
                
                sliders.append(slider)
            }
        }
    }
    
    lazy var label: UILabel = {
        return UILabel()
    }()
    var sliders: [DiscreteSlider]!
}

class BrewVariableSliderDelegate: DiscreteSliderDelegate {
    
    let brewVariable: BrewVariable
    let onChange: (BrewVariable, Int) -> ()
    
    init(brewVariable: BrewVariable, onChange: @escaping (BrewVariable, Int) -> ()) {
        self.brewVariable = brewVariable
        self.onChange = onChange
    }
    
    func onValueChanged(value: SliderValue) {
        onChange(brewVariable, value.index)
    }
    
}
