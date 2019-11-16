//
//  AllDoneSceneView.swift
//  AIropress
//
//  Created by Tomas Skypala on 13/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import TinyConstraints
import UIKit

class AllDoneSceneView: BaseSceneView {

    lazy var allDoneLabelContainer: UIView = {
        let container = UIView()

        let label = allDoneLabel
        container.addSubview(label)
        label.centerXToSuperview()

        return container
    }()

    lazy var makeAnotherButton: UIButton = {
        BaseSceneView.createButton(title: "Make Another", color: Style.Color.buttonPositive)
    }()

    private lazy var allDoneLabel: UILabel = {
        let label = UILabel()
        label.text = "All done"
        label.textAlignment = .center
        label.font = Style.Font.make(ofSize: .xlarge, weight: .medium)
        return label
    }()

    override func addViews() {
        super.addViews()

        addSubview(allDoneLabelContainer)
        addSubview(makeAnotherButton)
    }

    override func setColors() {
        super.setColors()

        allDoneLabel.textColor = Style.Color.text
        BaseSceneView.colorizeButton(makeAnotherButton)
    }

    override func setConstraints() {
        super.setConstraints()

        allDoneLabelContainer.height(120)

        allDoneLabelContainer.centerInSuperview()

        makeAnotherButton.centerXToSuperview()
        makeAnotherButton.bottomToSuperview(offset: -15, usingSafeArea: true)
    }
}
