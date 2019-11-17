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

protocol DiscreteSliderDelegate: AnyObject {
    func onValueChanged(to value: SliderValue)
}

class DiscreteSlider: UISlider {

    weak var delegate: DiscreteSliderDelegate?

    var stepCount: Int {
        set {
            let sliderMax = newValue - 1
            guard sliderMax > 0 else { return }

            values = Array(0 ... sliderMax).map { "\($0)" }
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

            minimumValue = 0
            maximumValue = Float(values.count - 1)

            addTarget(
                self, action: #selector(actionTarget),
                for: .valueChanged
            ) // TODO: make sendAction work even without adding a target
        }
    }

    private var previousRoundValue: Int?

    @objc
    func actionTarget() {}

    override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        guard let values = values else { fatalError("Property values must be set beforehand.") }

        let valueRounded = Int(value.rounded())
        guard valueRounded != previousRoundValue else {
            setValue(Float(valueRounded), animated: false)
            return
        }
        previousRoundValue = valueRounded

        setValue(Float(valueRounded), animated: true)

        let sliderValue = SliderValue(
            index: valueRounded,
            raw: value / maximumValue,
            text: values[valueRounded]
        )
        delegate?.onValueChanged(to: sliderValue)

        super.sendAction(action, to: target, for: event)
    }
}
