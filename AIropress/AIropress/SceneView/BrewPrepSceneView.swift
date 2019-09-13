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
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    private lazy var whatToDoLabelContainer: UIView = {
        let container = UIView()
        
        let label = UILabel()
        label.text = "What to do:"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: AppOptions.fontSize.large, weight: .regular)
        
        container.addSubview(label)
        label.topToSuperview()
        
        return container
    }()
    
    lazy var resetButton: UIButton = {
        return BaseSceneView.createResetButton()
    }()
    
    lazy var brewButton: UIButton = {
        return BaseSceneView.createButton(title: "Brew")
    }()
    
    override func getSceneLabelText() -> String {
        return "Get ready to brew"
    }
    
    override func addViews() {
        super.addViews()
        
        addSubview(whatToDoLabelContainer)
        addSubview(tableView)
        addSubview(resetButton)
        addSubview(brewButton)
    }
    
    override func setContraints() {
        super.setContraints()
        
        whatToDoLabelContainer.height(55)
        
        whatToDoLabelContainer.edges(to: contentContainer, excluding: LayoutEdge.init(arrayLiteral: [.bottom]))
        
        tableView.topToBottom(of: whatToDoLabelContainer)
        tableView.edges(to: contentContainer, excluding: LayoutEdge.init(arrayLiteral: [.top]), insets: TinyEdgeInsets(horizontal: 15, vertical: 0))
        
        resetButton.centerY(to: bottomButtonContainer)
        brewButton.centerY(to: bottomButtonContainer)
        resetButton.left(to: bottomButtonContainer)
        brewButton.right(to: bottomButtonContainer)
    }
}
