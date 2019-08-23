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
        self.setContraints()
    }
    
    func addViews() {
    }
    
    func setContraints() {
    }
    
    static func createButton(title: String, color: UIColor = AppOptions.color.button) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.backgroundColor = color
        button.setTitleColor(.white, for: .normal)
        button.setTitle(title, for: .normal)
        return button
    }
}
