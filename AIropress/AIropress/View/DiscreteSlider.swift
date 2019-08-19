//
//  DiscreteSlider.swift
//  AIropress
//
//  Created by Tomas Skypala on 19/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

struct SliderValue {
    let index: Int
    let raw: Float
    
    let text: String
}

protocol DiscreteSliderDelegate {
    func onValueChanged(value: SliderValue)
}

class DiscreteSlider: UISlider {
    
    var delegate: DiscreteSliderDelegate?
    var values: [String]? {
        didSet {
            guard let values = values else { return }
            
            self.minimumValue = 0
            self.maximumValue = Float(values.count - 1)
        }
    }
    
    override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        guard let values = values else { fatalError("Property values must be set beforehand.") }
        
        let valueRounded = self.value.rounded()
        guard self.value.truncatingRemainder(dividingBy: 1) == 0 else {
            self.setValue(valueRounded, animated: true)
            return
        }
        
        let valueIndex = Int(valueRounded)
        delegate?.onValueChanged(value: SliderValue(index: valueIndex, raw: self.value / maximumValue, text: values[valueIndex]))
        
        super.sendAction(action, to: target, for: event)
    }
}
