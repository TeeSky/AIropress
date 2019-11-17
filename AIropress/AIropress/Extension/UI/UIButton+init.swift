//
//  UIButton+init.swift
//  AIropress
//
//  Created by Tomas Skypala on 17/11/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import UIKit

extension UIButton {

    enum ButtonStyle {
        case normal(withTitle: String)
        case negative(withTitle: String? = nil)
        case positive(withTitle: String? = nil)
    }

    convenience init(withTitle title: String) {
        self.init(.normal(withTitle: title))
    }

    convenience init(_ style: ButtonStyle) {
        switch style {
        case .normal(let title):
            self.init(title: title)
        case .negative(let title):
            self.init(title: title ?? "Cancel", color: Style.Color.buttonNegative)
        case .positive(let title):
            self.init(title: title ?? "Ok", color: Style.Color.buttonPositive)
        }
    }

    /**
     Inits default styled **UIButton** using provided attributes.

     - Parameter title: Text to be set as titleLabel.text of the **UIButton**.
     - Parameter color: Color of **UIButton**'s background.
     - Parameter width: **UIButton**'s view width.

     - Returns: Commonly styled **UIButton**.
     */
    private convenience init(
        title: String,
        color: UIColor = Style.Color.buttonNormal,
        width: CGFloat = 150.0
    ) {
        self.init()

        layer.cornerRadius = 5
        backgroundColor = color
        setTitle(title, for: .normal)
        self.width(width)
    }
}
