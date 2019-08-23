//
//  BrewVariableBundleCellView.swift
//  AIropress
//
//  Created by Tomas Skypala on 23/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints

class BrewVariableBundleCellView: BaseCellView {
    
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
    
    var sliders: [BrewVariableSlider] = []
    
    override func addViews() {
        addSubview(contentContainer)
        addSubview(label)
        addSubview(slidersContainer)
    }
    
    override func setContraints() {
        contentContainer.edgesToSuperview(insets: TinyEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        
        slidersContainer.leftToSuperview(offset: 5)
        slidersContainer.rightToSuperview(offset: -5)
        slidersContainer.stack(sliders, axis: .vertical)
        
        label.centerXToSuperview()
        label.top(to: contentContainer)
        
        slidersContainer.bottom(to: contentContainer)
    }
    
    override func prepareForReuse() {
        label.text = ""
        sliders.forEach { $0.removeFromSuperview() }
        sliders = []
    }
}
