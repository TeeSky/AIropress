//
//  UISwitch+init.swift
//  AIropress
//
//  Created by Tomas Skypala on 17/11/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import UIKit

extension UISwitch {

    enum SwitchStyle {
        case normal

        var tintColor: UIColor {
            switch self {
            case .normal: return Style.Color.tint
            }
        }
    }

    convenience init(_ style: SwitchStyle) {
        self.init()

        onTintColor = style.tintColor
    }
}
