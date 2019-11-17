//
//  BrewDoneSceneView.swift
//  AIropress
//
//  Created by Tomas Skypala on 13/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import TinyConstraints
import UIKit

class BrewDoneSceneView: BaseSceneView {

    lazy var brewDoneLabelContainer: UIView = {
        let container = UIView()

        let label = brewDoneLabel
        container.addSubview(label)
        label.centerXToSuperview()

        return container
    }()

    lazy var makeAnotherButton: UIButton = {
        BaseSceneView.createButton(title: "Make Another", color: Style.Color.buttonPositive)
    }()

    private lazy var brewDoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Brew done"
        label.textAlignment = .center
        label.font = Style.Font.make(ofSize: .xlarge, weight: .medium)
        return label
    }()
    
    override func addViews() {
        super.addViews()

        addSubview(brewDoneLabelContainer)
        addSubview(makeAnotherButton)
    }

    override func setColors() {
        super.setColors()

        brewDoneLabel.textColor = Style.Color.text
        BaseSceneView.colorizeButton(makeAnotherButton)
    }

    override func setConstraints() {
        super.setConstraints()

        brewDoneLabelContainer.height(120)

        brewDoneLabelContainer.centerInSuperview()

        makeAnotherButton.centerXToSuperview()
        makeAnotherButton.bottomToSuperview(offset: -15, usingSafeArea: true)
    }
}
