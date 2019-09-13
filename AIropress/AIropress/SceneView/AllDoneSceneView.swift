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
    
    lazy var safeAreaContainer: UIView = {
        return UIView()
    }()
    
    lazy var allDoneLabelContainer: UIView = {
        let container = UIView()
        
        let label = UILabel()
        label.text = "All done"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: AppOptions.fontSize.xlarge, weight: .heavy)
        
        container.addSubview(label)
        label.centerYToSuperview()
        
        return container
    }()
    
    lazy var makeAnotherButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Make Another"
        return button
    }()
    
    override func addViews() {
        addSubview(safeAreaContainer)
        addSubview(allDoneLabelContainer)
        addSubview(makeAnotherButton)
    }
    
    override func setConstraints() {
        safeAreaContainer.edgesToSuperview(insets: TinyEdgeInsets(horizontal: 15), usingSafeArea: true)
        
        allDoneLabelContainer.height(120)
        makeAnotherButton.height(65)
        
        allDoneLabelContainer.centerInSuperview()
        
        makeAnotherButton.centerXToSuperview()
        makeAnotherButton.bottom(to: safeAreaContainer)
    }
}
