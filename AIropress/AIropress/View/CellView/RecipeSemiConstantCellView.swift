//
//  RecipeSemiConstantCellView.swift
//  AIropress
//
//  Created by Tomas Skypala on 23/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

class RecipeSemiConstantCellView: BaseCellView {
    
    lazy var constantView: RecipeConstantCellView = {
        return RecipeConstantCellView()
    }()
    
    lazy var confidenceSlider: BrewVariableSlider = {
        return BrewVariableSlider()
    }()

    override func addViews() {
        constantView.addViews()
        addSubview(constantView)
        addSubview(confidenceSlider)
    }
    
    override func setContraints() {
        constantView.setContraints()
        
        self.stack([constantView, confidenceSlider], spacing: 10)
    }
}
