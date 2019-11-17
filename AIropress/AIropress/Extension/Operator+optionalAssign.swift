//
//  Operator+optionalAssign.swift
//  AIropress
//
//  Created by Tomas Skypala on 17/11/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

infix operator ?=

public func ?= <T>(lhs: inout T, rhs: T?) {
    lhs = rhs ?? lhs
}
