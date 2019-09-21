//
//  BrewRecipeTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 21/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class BrewRecipeTests: XCTestCase {

    func testCreateFilterRecipe() {
        let filterRecipe = BrewRecipe.createDefaultFilterRecipe(bundle: Bundle(for: type(of: self)))

        XCTAssertNotNil(filterRecipe)
    }
}
