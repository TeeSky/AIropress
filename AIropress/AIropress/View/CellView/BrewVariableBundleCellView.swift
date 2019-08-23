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
        let container = UIView()
        return container
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
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
        contentContainer.addSubview(label)
        contentContainer.addSubview(slidersContainer)
    }
    
    override func setContraints() {
        let contentInset: CGFloat = 10
        contentContainer.edgesToSuperview(insets: TinyEdgeInsets(top: contentInset, left: contentInset, bottom: contentInset, right: contentInset))
        
        slidersContainer.leftToSuperview()
        slidersContainer.rightToSuperview()
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
