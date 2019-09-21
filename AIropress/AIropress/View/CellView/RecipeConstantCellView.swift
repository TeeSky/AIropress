//
//  RecipeConstantCellView.swift
//  AIropress
//
//  Created by Tomas Skypala on 23/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints

class RecipeConstantCellView: BaseCellView {

    lazy var constantLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: AppOptions.fontSize.normal, weight: .regular)
        return label
    }()

    lazy var constantValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: AppOptions.fontSize.normal, weight: .bold)
        return label
    }()

    private lazy var contentContainer: UIView = {
        let container = UIView()
        return container
    }()

    override func addViews() {
        addSubview(contentContainer)

        contentContainer.addSubview(constantLabel)
        contentContainer.addSubview(constantValue)
    }

    override func setConstraints() {
        contentContainer.edgesToSuperview(insets: TinyEdgeInsets(top: 5))

        constantLabel.leftToSuperview()
        constantLabel.centerYToSuperview()

        constantValue.rightToSuperview()
        constantValue.centerYToSuperview()
    }
}
