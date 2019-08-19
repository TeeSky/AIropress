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

class DesiredTasteSceneView: BaseSceneView {
    
    var sceneLabel: UILabel!
    var calculateButton: UIButton!
    var tableView: UITableView!
    
    override func render() {
        self.backgroundColor = .white
        
        setupLabel()
        setupCalculateButton()
//        setupTableView(under: sceneLabel, above: calculateButton)
    }
    
    private func setupLabel() {
        sceneLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        sceneLabel.text = "Desired"
        sceneLabel.textColor = .black
        sceneLabel.textAlignment = .left
        sceneLabel.font = UIFont.systemFont(ofSize: 35, weight: .heavy)
        
        self.addSubview(sceneLabel)
        
        sceneLabel.topToSuperview(offset: 75)
        sceneLabel.leftToSuperview(offset: 15)
        sceneLabel.rightToSuperview()
    }
    
    private func setupCalculateButton() {
        calculateButton = UIButton(type: .roundedRect)
        calculateButton.frame = CGRect(x: 0, y: 0, width: 250, height: 150)
        calculateButton.backgroundColor = .green
        calculateButton.setTitle("Calculate", for: .normal)
        
        self.addSubview(calculateButton)
        
        calculateButton.centerInSuperview()
    }
    
    private func setupTableView(under label: UIView, above: UIView) {
        tableView = UITableView()

        self.addSubview(tableView)
        
        tableView.topToBottom(of: label)
        tableView.leftToSuperview()
        tableView.rightToSuperview()
        tableView.bottomToTop(of: above)
    }
}
