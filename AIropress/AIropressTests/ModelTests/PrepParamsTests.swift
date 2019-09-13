//
//  PrepParamsTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 04/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class PrepParamsTests: XCTestCase {
    
    func testCreateNonNil() {
        let valuesMap = [RecipeValueId.temperature.rawValue: 90,
                         RecipeValueId.coffeeAmount.rawValue: 18,
                         RecipeValueId.aeropressOrientation.rawValue: AeropressBrewOrientation.inverted.value(),
                         48: 54.5]
        
        let prepParams = PrepParams.create(values: valuesMap)
        
        XCTAssertNotNil(prepParams)
    }
    
    func testCreateNilWithInsufficientValues() {
        let valuesMap = [256: 1.0,
                         RecipeValueId.temperature.rawValue: 92,
                         RecipeValueId.aeropressOrientation.rawValue: AeropressBrewOrientation.normal.value(),
                         91: 58.1]
        
        let prepParams = PrepParams.create(values: valuesMap)
        
        XCTAssertNil(prepParams)
    }
}
