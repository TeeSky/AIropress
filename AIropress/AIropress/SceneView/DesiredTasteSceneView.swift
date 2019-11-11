//
//  DesiredTasteSceneView.swift
//  AIropress
//
//  Created by Tomas Skypala on 19/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints

class DesiredTasteSceneView: LabeledSceneView {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    lazy var calculateButton: UIButton = {
        return BaseSceneView.createButton(title: "Calculate")
    }()

    override func getSceneLabelText() -> String {
        return "Desired"
    }

    override func addViews() {
        super.addViews()

        addSubview(tableView)
        addSubview(calculateButton)
    }

    override func setColors() {
        super.setColors()

        tableView.backgroundColor = Style.Color.background
        BaseSceneView.colorizeButton(calculateButton)
    }

    override func setConstraints() {
        super.setConstraints()

        tableView.edges(to: contentContainer)

        calculateButton.centerY(to: bottomButtonContainer)
        calculateButton.right(to: bottomButtonContainer)
    }
}
