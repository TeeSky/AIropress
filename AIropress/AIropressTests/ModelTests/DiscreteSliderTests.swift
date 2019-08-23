//
//  DiscreteSliderTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 19/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class DiscreteSliderTests: XCTestCase {
    
    private var slider: DiscreteSlider!
    
    override func setUp() {
        super.setUp()
        
        slider = DiscreteSlider()
    }
    
    func testValuesInit() {
        let expectedSliderValues = ["smthn", "smthnels", "smthnelstoo"]
        let expectedStepCount = 3
        
        slider.values = expectedSliderValues
        
        XCTAssertEqual(expectedSliderValues, slider.values)
        XCTAssertEqual(expectedStepCount, slider.stepCount)
    }
    
    func testStepCountInit() {
        let stepCount = 4
        let expectedSliderValues = ["0", "1", "2", "3"]
        
        slider.stepCount = stepCount
        
        XCTAssertEqual(expectedSliderValues, slider.values)
    }
    
    func testLowStepCountInitFail() {
        let stepCount = 1
        let expectedSliderValues: [String]? = nil
        
        slider.stepCount = stepCount
        
        XCTAssertEqual(expectedSliderValues, slider.values)
    }
    
    func testSetInitialValue() {
        let stepCount = 10
        let initialValue: Float = 0.5
        let expectedSliderValue: Float = 5
        
        slider.stepCount = stepCount
        slider.initialValue = initialValue
        
        XCTAssertEqual(expectedSliderValue, slider.value)
    }
}
