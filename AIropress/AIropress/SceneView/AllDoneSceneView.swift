//
//  AllDoneSceneView.swift
//  AIropress
//
//  Created by Tomas Skypala on 13/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints

class AllDoneSceneView: BaseSceneView {
    
    lazy var allDoneLabelContainer: UIView = {
        let container = UIView()
        
        let label = UILabel()
        label.text = "All done"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: AppOptions.fontSize.xlarge, weight: .medium)
        
        container.addSubview(label)
        label.centerXToSuperview()
        
        return container
    }()
    
    lazy var makeAnotherButton: UIButton = {
        return BaseSceneView.createButton(title: "Make Another", color: AppOptions.color.buttonPositive)
    }()
    
    override func addViews() {
        addSubview(allDoneLabelContainer)
        addSubview(makeAnotherButton)
    }
    
    override func setConstraints() {
        allDoneLabelContainer.height(120)
        
        allDoneLabelContainer.centerInSuperview()
        
        makeAnotherButton.centerXToSuperview()
        makeAnotherButton.bottomToSuperview(offset: -15, usingSafeArea: true)
    }
}
