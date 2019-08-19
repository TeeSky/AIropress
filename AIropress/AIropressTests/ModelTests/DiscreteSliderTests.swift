//
//  DiscreteSliderTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 19/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class DiscreteSliderTests: XCTestCase {
    
    var sliderValues: [String]!
    var slider: DiscreteSlider!
    
    override func setUp() {
        super.setUp()
        
        sliderValues = ["smthn", "smthnels", "smthnelstoo"]
        slider = DiscreteSlider()
        slider.values = sliderValues
    }
    
    func testInit() {
        let expectedSliderValues = sliderValues
        
        XCTAssertEqual(expectedSliderValues, slider.values)
    }
}
