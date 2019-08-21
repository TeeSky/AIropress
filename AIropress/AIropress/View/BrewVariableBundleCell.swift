//
//  BrewVariableBundleCell.swift
//  AIropress
//
//  Created by Tomas Skypala on 19/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints

class BrewVariableBundleCell: UITableViewCell {
    
    private var didSetConstraints = false
    
    private lazy var contentContainer: UIView = {
        return UIView()
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        return label
    }()
    
    lazy var slidersContainer: UIView = {
        let container = UIView()
        return container
    }()
    
    var sliders: [BrewVariableSlider]!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        label.text = ""
        sliders.forEach { $0.removeFromSuperview() }
        sliders = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func updateConstraints() {
        if !didSetConstraints {
            contentContainer.edgesToSuperview(insets: TinyEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
            
            slidersContainer.leftToSuperview(offset: 5)
            slidersContainer.rightToSuperview(offset: -5)
            slidersContainer.stack(sliders, axis: .vertical)
            
            label.centerX(to: contentContainer)
            label.top(to: contentContainer)
            
            slidersContainer.bottom(to: contentContainer)
            
            didSetConstraints = true
        }
        
        super.updateConstraints()
    }
    
    private func addViews() {
        addSubview(contentContainer)
        addSubview(label)
        addSubview(slidersContainer)
    }
}

extension BrewVariableBundleCell: BaseTableCell {
    
    func configure(viewModel: BaseTableCellVM) {
        guard let viewModel = viewModel as? BrewVariableBundleCellVM else { fatalError("Unexpected view model type.") }
        
        setupLabel(viewModel: viewModel)
        setupSliders(viewModel: viewModel)
        
        didSetConstraints = false // TODO fix on-scroll broken slider cell layout
        needsUpdateConstraints()
    }
    
    private func setupLabel(viewModel: BrewVariableBundleCellVM) {
        label.text = viewModel.sliderLabel
    }
    
    private func setupSliders(viewModel: BrewVariableBundleCellVM) {
        sliders = []
        for variable in viewModel.sliderVariables {
            let slider = BrewVariableSlider(brewVariable: variable, initialValue: viewModel.initialSliderValue(for: variable))
            slider.delegate = { sliderValue in
                viewModel.onSliderValueChanged(brewVariable: variable, valueIndex: sliderValue.index)
            }
            
            sliders.append(slider)
            slidersContainer.addSubview(slider)
        }
    }
}
