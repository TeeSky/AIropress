//
//  BrewRecipeTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 21/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class BrewRecipeTests: XCTestCase {

    func testCreateDefaultFilterRecipe() {
        let filterRecipe = BrewRecipe.createDefaultFilterRecipe(bundle: Bundle(for: Self.self))

        XCTAssertNotNil(filterRecipe)
    }

    func testCreateDefaultPrismoEspressoRecipe() {
        let espressoRecipe = BrewRecipe.createDefaultPrismoEspressoRecipe(bundle: Bundle(for: Self.self))

        XCTAssertNotNil(espressoRecipe)
    }
}
