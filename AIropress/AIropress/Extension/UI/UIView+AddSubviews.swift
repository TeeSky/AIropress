//
//  UIView+AddSubviews.swift
//  AIropress
//
//  Created by Tomáš Skýpala on 14.04.2021.
//  Copyright © 2021 Tomas Skypala. All rights reserved.
//

import UIKit

extension UIView {

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
