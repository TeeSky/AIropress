//
//  BaseTestCase.swift
//  AIropressTests
//
//  Created by Skypy on 17/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class BaseTestCase: XCTestCase {

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
    }

}
