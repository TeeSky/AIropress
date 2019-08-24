//
//  RecipeSemiConstantCellView.swift
//  AIropress
//
//  Created by Tomas Skypala on 23/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints

class RecipeSemiConstantCellView: BaseCellView {
    
    lazy var constantView: RecipeConstantCellView = {
        return RecipeConstantCellView()
    }()
    
    lazy var confidenceSlider: BrewVariableSlider = {
        return BrewVariableSlider()
    }()
    
    private lazy var contentContainer: UIView = {
        return UIView()
    }()

    override func addViews() {
        addSubview(contentContainer)
        
        constantView.addViews()
        contentContainer.addSubview(constantView)
        contentContainer.addSubview(confidenceSlider)
    }
    
    override func setContraints() {
        contentContainer.edgesToSuperview(insets: TinyEdgeInsets(top: 15))
        constantView.setContraints()
        
        contentContainer.stack([constantView, confidenceSlider], spacing: 10)
    }
}
