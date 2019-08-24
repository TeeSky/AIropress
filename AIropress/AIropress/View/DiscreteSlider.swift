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

class DiscreteSlider: UISlider {
    typealias Delegate = ((SliderValue) -> ())
    
    var delegate: Delegate?
    
    var stepCount: Int {
        set {
            let sliderMax = newValue - 1
            guard sliderMax > 0 else { return }
            
            values = Array(0...sliderMax).map { "\($0)" }
        }
        get {
            return values?.count ?? 0
        }
    }
    
    var initialValue: Float! {
        didSet {
            value = initialValue * Float(stepCount - 1)
        }
    }
    
    var values: [String]? {
        didSet {
            guard let values = values else { return }
            
            self.minimumValue = 0
            self.maximumValue = Float(values.count - 1)
            
            self.addTarget(self, action: #selector(actionTarget), for: .valueChanged) // TODO make sendAction work even without adding a target
        }
    }
    
    @objc
    func actionTarget() {
    }
    
    override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        guard let values = values else { fatalError("Property values must be set beforehand.") }
        
        let valueRounded = self.value.rounded()
        let sliderIsOnRoundValue = self.value.truncatingRemainder(dividingBy: 1) == 0
        guard sliderIsOnRoundValue else {
            self.setValue(valueRounded, animated: true)
            return
        }
        
        let valueIndex = Int(valueRounded)
        let sliderValue = SliderValue(index: valueIndex,
                                      raw: self.value / maximumValue,
                                      text: values[valueIndex])
        delegate?(sliderValue)
        
        super.sendAction(action, to: target, for: event)
    }
}
