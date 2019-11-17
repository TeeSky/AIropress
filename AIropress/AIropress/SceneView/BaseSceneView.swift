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
        addViews()
        setColors()
        setConstraints()
    }

    /**
     Adds all **UIView** elements into base view.

     - Warning: This fuction is should be overriden by the subclass.
     */
    func addViews() {}

    /**
     Sets up colors of all UI components of the view.

     - Warning: This fuction is should be overriden by the subclass.
     */
    func setColors() {
        backgroundColor = Style.Color.background
    }

    /**
     Sets up all UI constraints of the view.

     - Warning: This fuction is should be overriden by the subclass.
     */
    func setConstraints() {}

    /**
     Creates default styled negative **UIButton**, that is colored red and with smaller width 90.

     - Parameter title: Text to be set as titleLabel.text of the **UIButton**.

     - Returns: Commonly styled reset **UIButton**.
     */
    static func createNegativeButton(title: String = "Reset") -> UIButton {
        let button = BaseSceneView.createButton(title: title, color: Style.Color.buttonNegative, width: 90.0)
        return button
    }

    /**
     Creates default styled **UIButton** using provided attributes.

     - Parameter title: Text to be set as titleLabel.text of the **UIButton**.
     - Parameter color: Color of **UIButton**'s background.
     - Parameter width: **UIButton**'s view width.

     - Returns: Commonly styled **UIButton**.
     */
    static func createButton(
        title: String,
        color: UIColor = Style.Color.buttonNormal,
        width: CGFloat = 150.0
    ) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.backgroundColor = color
        button.setTitle(title, for: .normal)
        button.width(width)
        return button
    }

    static func colorizeButton(
        _ button: UIButton,
        backgroundColor: UIColor = Style.Color.buttonNormal,
        textColor: UIColor = Style.Color.textButton
    ) {
        button.backgroundColor = backgroundColor
        button.setTitleColor(textColor, for: .normal)
    }

    static func colorizeSwitch(
        _ uiSwitch: UISwitch,
        tintColor: UIColor = Style.Color.tint
    ) {
        uiSwitch.onTintColor = tintColor
    }
}
