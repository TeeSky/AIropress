//
//  BaseSceneView.swift
//  AIropress
//
//  Created by Tomas Skypala on 19/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

/**
 App scene view base class, providing simple and clear inheritable view initiating functions.
 
 Provided are also static factory fuctions for unified common UI element creation.
 */
class BaseSceneView: UIView {
    
    /**
     Sets default white background and sets up view by calling addViews and setConstraints.
     
     This fuction is called by **BaseViewController** upon viewDidLoad.
     */
    func render() {
        self.backgroundColor = .white
        
        self.addViews()
        self.setConstraints()
    }
    
    /**
     Adds all **UIView** elements into base view.
     
     - Warning: This fuction is should be overriden by the subclass.
     */
    func addViews() {
    }
    
    /**
     Sets up all UI constraints of view.
     
     - Warning: This fuction is should be overriden by the subclass.
     */
    func setConstraints() {
    }
    
    /**
     Creates default styled reset **UIButton**.
     
     - Returns: Commonly styled reset **UIButton**.
     */
    static func createResetButton() -> UIButton {
        let button = BaseSceneView.createButton(title: "Reset", color: AppOptions.color.buttonNegative, width: 90.0)
        return button
    }
    
    /**
     Creates default styled **UIButton** using provided attributes.
     
     - Parameter title: Text to be set as titleLabel.text of the **UIButton**.
     - Parameter color: Color of **UIButton**'s background.
     - Parameter width: **UIButton**'s view width.
     
     - Returns: Commonly styled **UIButton**.
     */
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
