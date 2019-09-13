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
    
    lazy var minLabel: UILabel = {
        return BrewVariableSlider.createStyledLabel()
    }()
    
    lazy var maxLabel: UILabel = {
        return BrewVariableSlider.createStyledLabel()
    }()
    
    private lazy var sliderContainer: UIView = {
        return UIView()
    }()
    
    private lazy var slider: DiscreteSlider = {
        let slider = DiscreteSlider()
        return slider
    }()
    
    private lazy var bottomLabelsContainer: UIView = {
        return UIView()
    }()
    
    private var didUpdateConstraints = false
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(brewVariable: BrewVariable, initialValue: Float) {
        slider.stepCount = brewVariable.stepCount
        minLabel.text = brewVariable.labelSet.minLabel
        maxLabel.text = brewVariable.labelSet.maxLabel
        
        slider.initialValue = initialValue
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            self.height(CGFloat(BrewVariableSlider.height))

            sliderContainer.leftToSuperview()
            sliderContainer.rightToSuperview()
            slider.edgesToSuperview(insets: TinyEdgeInsets(horizontal: 10))
            
            self.stack([sliderContainer, bottomLabelsContainer], axis: .vertical, spacing: 5)
            
            minLabel.leftToSuperview()
            maxLabel.rightToSuperview()
            
            didUpdateConstraints = true
        }
        
        super.updateConstraints()
    }
    
    private func addViews() {
        addSubview(sliderContainer)
        sliderContainer.addSubview(slider)
        bottomLabelsContainer.addSubview(minLabel)
        bottomLabelsContainer.addSubview(maxLabel)
        addSubview(bottomLabelsContainer)
    }
    
    private static func createStyledLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: AppOptions.fontSize.small, weight: .light)
        return label
    }
}
