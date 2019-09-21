//
//  ViewRecipeSceneView.swift
//  AIropress
//
//  Created by Tomas Skypala on 23/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints

class ViewRecipeSceneView: LabeledSceneView {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    lazy var resetButton: UIButton = {
        return BaseSceneView.createNegativeButton()
    }()

    lazy var prepareButton: UIButton = {
        return BaseSceneView.createButton(title: "Prepare")
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

    override func setConstraints() {
        super.setConstraints()

        tableView.edges(to: contentContainer)

        resetButton.centerY(to: bottomButtonContainer)
        prepareButton.centerY(to: bottomButtonContainer)
        resetButton.left(to: bottomButtonContainer)
        prepareButton.right(to: bottomButtonContainer)
    }
}
