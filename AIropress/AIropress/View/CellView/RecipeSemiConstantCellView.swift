//
//  RecipeSemiConstantCellView.swift
//  AIropress
//
//  Created by Tomas Skypala on 23/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import TinyConstraints
import UIKit

class RecipeSemiConstantCellView: BaseCellView {

    lazy var constantView: RecipeConstantCellView = {
        RecipeConstantCellView()
    }()

    lazy var confidenceSlider: BrewVariableSlider = {
        BrewVariableSlider()
    }()

    private lazy var contentContainer: UIView = {
        UIView()
    }()

    override func addViews() {
        addSubview(contentContainer)

        constantView.addViews()
        contentContainer.addSubview(constantView)
        contentContainer.addSubview(confidenceSlider)
    }

    override func setConstraints() {
        contentContainer.edgesToSuperview(insets: TinyEdgeInsets(top: 15))
        constantView.setConstraints()

        contentContainer.stack([constantView, confidenceSlider], spacing: 10)
    }
}
