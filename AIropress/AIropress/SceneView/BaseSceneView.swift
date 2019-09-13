//
//  BaseSceneView.swift
//  AIropress
//
//  Created by Tomas Skypala on 19/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

class BaseSceneView: UIView {
    
    func render() {
        self.backgroundColor = .white
        
        self.addViews()
        self.setConstraints()
    }
    
    func addViews() {
    }
    
    func setConstraints() {
    }
    
    static func createResetButton() -> UIButton {
        let button = BaseSceneView.createButton(title: "Reset", color: AppOptions.color.buttonNegative, width: 90.0)
        return button
    }
    
    static func createButton(title: String, color: UIColor = AppOptions.color.button, width: CGFloat = 150.0) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.backgroundColor = color
        button.setTitleColor(.white, for: .normal)
        button.setTitle(title, for: .normal)
        button.width(width)
        return button
    }
}
