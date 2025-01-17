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
        label.font = Style.Font.make(ofSize: .large, weight: .bold)
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

    override func setConstraints() {
        contentContainer.edgesToSuperview(insets: TinyEdgeInsets(top: 5))

        slidersContainer.leftToSuperview()
        slidersContainer.rightToSuperview()
        slidersContainer.stack(sliders, axis: .vertical)

        label.top(to: contentContainer)

        slidersContainer.bottom(to: contentContainer)
    }

    override func prepareForReuse() {
        label.text = ""
        sliders.forEach { $0.removeFromSuperview() }
        sliders = []
    }
}
