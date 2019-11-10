//
//  AppOptionsTests.swift
//  AIropressTests
//
//  Created by Tomáš Skýpala on 10/11/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class AppOptionsTests: XCTestCase {

    func testMakeAppBrewVariableBundlesFromAssets() {
        let variableBundles = AppBrewVariableBundles.makeFromAssets(bundle: Bundle(for: Self.self))

        XCTAssertNotNil(variableBundles)
    }

}
