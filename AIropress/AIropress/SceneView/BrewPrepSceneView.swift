//
//  BrewPrepSceneView.swift
//  AIropress
//
//  Created by Tomas Skypala on 30/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints

class BrewPrepSceneView: LabeledSceneView {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Style.Color.background
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false

        return tableView
    }()

    private lazy var whatToDoLabelContainer: UIView = {
        let container = UIView()

        let label = UILabel()
        label.text = "What to do:"
        label.textColor = Style.Color.text
        label.textAlignment = .left
        label.font = Style.Font.make(ofSize: .large)

        container.addSubview(label)
        label.topToSuperview()

        return container
    }()

    lazy var resetButton: UIButton = {
        return BaseSceneView.createNegativeButton()
    }()

    lazy var brewButton: UIButton = {
        return BaseSceneView.createButton(title: "Brew")
    }()

    override func getSceneLabelText() -> String {
        return "Prepare for brew"
    }

    override func addViews() {
        super.addViews()

        addSubview(whatToDoLabelContainer)
        addSubview(tableView)
        addSubview(resetButton)
        addSubview(brewButton)
    }

    override func setColors() {
        super.setColors()

        tableView.backgroundColor = Style.Color.background
        BaseSceneView.colorizeButton(brewButton)
    }

    override func setConstraints() {
        super.setConstraints()

        whatToDoLabelContainer.height(55)

        whatToDoLabelContainer.edges(to: contentContainer, excluding: LayoutEdge.init(arrayLiteral: [.bottom]))

        tableView.topToBottom(of: whatToDoLabelContainer)
        tableView.edges(to: contentContainer, excluding: LayoutEdge.init(arrayLiteral: [.top]))

        resetButton.centerY(to: bottomButtonContainer)
        brewButton.centerY(to: bottomButtonContainer)
        resetButton.left(to: bottomButtonContainer)
        brewButton.right(to: bottomButtonContainer)
    }
}
