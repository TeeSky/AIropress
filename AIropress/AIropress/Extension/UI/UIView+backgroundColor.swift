//
//  UIView+backgroundColor.swift
//  AIropress
//
//  Created by Tomáš Skýpala on 11/11/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import UIKit

extension UIView {

    convenience init(backgroundColor: UIColor) {
        self.init()

        self.backgroundColor = backgroundColor
    }
}
