//
//  XCTestCase+setUp.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 17/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

extension XCTestCase {

    override open func setUp() {
        super.setUp()

        continueAfterFailure = false
    }

}
