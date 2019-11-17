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
        textAlignment: NSTextAlignment? = nil,
        font: UIFont = Style.Font.make()
    ) {
        self.init()

        self.text ?= text
        self.textAlignment ?= textAlignment
        self.font ?= font
    }
}
