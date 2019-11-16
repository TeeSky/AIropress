//
//  TinyEdgeInset+convienceInit.swift
//  AIropress
//
//  Created by Tomas Skypala on 23/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import TinyConstraints

extension TinyEdgeInsets {

    init(size: CGFloat) {
        self.init(top: size, left: size, bottom: size, right: size)
    }

    init(horizontal: CGFloat, vertical: CGFloat = 0) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    init(top: CGFloat) {
        self.init(top: top, left: 0, bottom: 0, right: 0)
    }
}
