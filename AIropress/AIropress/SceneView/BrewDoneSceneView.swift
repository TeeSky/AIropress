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

class BrewDoneSceneView: LabeledSceneView {

    private lazy var rateSwitchLabel: UILabel = {
        UILabel(text: "Rate?", textAlignment: .center)
    }()

    lazy var rateSwitch: UISwitch = {
        UISwitch(.normal)
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    lazy var rateSwitchContainer: UIView = {
        let container = UIView()

        let label = rateSwitchLabel
        let rSwitch = rateSwitch
        container.addSubview(label)
        container.addSubview(rSwitch)

        label.leftToSuperview()
        label.centerYToSuperview()

        rSwitch.rightToSuperview()
        rSwitch.centerYToSuperview()

        return container
    }()

    lazy var bottomButton: UIButton = {
        UIButton(.positive(withTitle: "Make Another"))
    }()

    override func getSceneLabelText() -> String {
        return "Brew done"
    }

    override func addViews() {
        super.addViews()

        addSubview(rateSwitchContainer)
        addSubview(tableView)
        addSubview(bottomButton)
    }

    override func setColors() {
        super.setColors()

        BaseSceneView.colorizeButton(bottomButton)
        BaseSceneView.colorizeSwitch(rateSwitch)
    }

    override func setConstraints() {
        super.setConstraints()

        rateSwitchContainer.height(70)
        rateSwitchContainer.edges(to: contentContainer, excluding: .bottom)

        tableView.topToBottom(of: rateSwitchContainer)
        tableView.edges(to: contentContainer, excluding: .top)

        bottomButton.center(in: bottomButtonContainer)
    }

    func setRateOn(_ rateOn: Bool) {
        if rateOn {
            tableView.isHidden = false
            bottomButton.titleLabel?.text = "Save & Finish"
        } else {
            tableView.isHidden = true
            bottomButton.titleLabel?.text = "Make Another"
        }
    }
}
