//
//  UILabel+init.swift
//  AIropress
//
//  Created by Tomas Skypala on 17/11/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import UIKit

extension UILabel {

    convenience init(
        text: String? = nil,
        textColor: UIColor? = nil,
        textAlignment: NSTextAlignment? = nil,
        font: UIFont? = nil
    ) {
        self.init()

        self.text ?= text
        self.textColor ?= textColor
        self.textAlignment ?= textAlignment
        self.font ?= font
    }
}
