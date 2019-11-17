//
//  ViewRecipeSceneView.swift
//  AIropress
//
//  Created by Tomas Skypala on 23/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import TinyConstraints
import UIKit

class ViewRecipeSceneView: LabeledSceneView {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    lazy var resetButton: UIButton = {
        BaseSceneView.createNegativeButton()
    }()

    lazy var prepareButton: UIButton = {
        BaseSceneView.createButton(title: "Prepare")
    }()

    override func getSceneLabelText() -> String {
        return "Recipe"
    }

    override func addViews() {
        super.addViews()

        addSubview(tableView)
        addSubview(resetButton)
        addSubview(prepareButton)
    }

    override func setColors() {
        super.setColors()

        tableView.backgroundColor = Style.Color.background
        BaseSceneView.colorizeButton(prepareButton)
        BaseSceneView.colorizeButton(resetButton, backgroundColor: Style.Color.buttonNegative)
    }

    override func setConstraints() {
        super.setConstraints()

        tableView.edges(to: contentContainer)

        resetButton.centerY(to: bottomButtonContainer)
        prepareButton.centerY(to: bottomButtonContainer)
        resetButton.left(to: bottomButtonContainer)
        prepareButton.right(to: bottomButtonContainer)
    }
}
