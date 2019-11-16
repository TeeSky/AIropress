//
//  LabeledSceneView.swift
//  AIropress
//
//  Created by Tomas Skypala on 30/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import TinyConstraints
import UIKit

class LabeledSceneView: BaseSceneView {

    lazy var safeAreaContainer: UIView = {
        UIView()
    }()

    private lazy var sceneLabel: UILabel = {
        let label = UILabel()
        label.text = getSceneLabelText()
        label.textColor = Style.Color.text
        label.textAlignment = .left
        label.font = Style.Font.make(ofSize: .xlarge, weight: .heavy)
        return label
    }()

    lazy var sceneLabelContainer: UIView = {
        let container = UIView()

        let label = self.sceneLabel
        container.addSubview(label)
        label.centerYToSuperview()

        return container
    }()

    lazy var contentContainer: UIView = {
        UIView()
    }()

    lazy var bottomButtonContainer: UIView = {
        UIView()
    }()

    func getSceneLabelText() -> String {
        fatalError("sceneLabelText function should be overriden.")
    }

    override func addViews() {
        super.addViews()

        addSubview(safeAreaContainer)
        addSubview(sceneLabelContainer)
        addSubview(contentContainer)
        addSubview(bottomButtonContainer)
    }

    override func setColors() {
        super.setColors()

        safeAreaContainer.backgroundColor = Style.Color.background
        sceneLabel.textColor = Style.Color.text
    }

    override func setConstraints() {
        super.setConstraints()

        safeAreaContainer.edgesToSuperview(insets: TinyEdgeInsets(horizontal: 15), usingSafeArea: true)

        sceneLabelContainer.height(120)
        bottomButtonContainer.height(65)

        safeAreaContainer.stack(
            [sceneLabelContainer, contentContainer, bottomButtonContainer],
            axis: .vertical, spacing: 5
        )
    }
}
