//
//  BrewVariableSlider.swift
//  AIropress
//
//  Created by Tomas Skypala on 20/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import TinyConstraints
import UIKit

class BrewVariableSlider: UIView {
    
    static let height = 75
    
    var delegate: DiscreteSlider.Delegate? {
        didSet {
            slider.delegate = delegate
        }
    }
    
    let brewVariable: BrewVariable
    private var didUpdateConstraints = false
    
    lazy var slider: DiscreteSlider = {
        let slider = DiscreteSlider()
        return slider
    }()
    
    private lazy var bottomLabelsContainer: UIView = {
        return UIView()
    }()
    
    lazy var minLabel: UILabel = {
        return BrewVariableSlider.createStyledLabel()
    }()
    
    lazy var maxLabel: UILabel = {
        return BrewVariableSlider.createStyledLabel()
    }()
    
    init(brewVariable: BrewVariable, initialValue: Float, frame: CGRect = CGRect.zero) {
        self.brewVariable = brewVariable
        super.init(frame: frame)
        addViews()
        
        slider.stepCount = brewVariable.stepCount
        slider.initialValue = initialValue
        minLabel.text = brewVariable.labelSet.minLabel
        maxLabel.text = brewVariable.labelSet.maxLabel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            self.height(CGFloat(BrewVariableSlider.height))
            
            self.stack([slider, bottomLabelsContainer], axis: .vertical, spacing: 5)
            
            minLabel.leftToSuperview()
            maxLabel.rightToSuperview()
            
            didUpdateConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func addViews() {
        addSubview(slider)
        bottomLabelsContainer.addSubview(minLabel)
        bottomLabelsContainer.addSubview(maxLabel)
        addSubview(bottomLabelsContainer)
    }
    
    private static func createStyledLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        return label
    }
}
