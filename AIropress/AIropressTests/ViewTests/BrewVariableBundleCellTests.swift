//
//  BrewVariableBundleCellTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 19/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

private class MockBrewVariableBundleCellVM: BrewVariableBundleCellVM {

    var valueChange: (BrewVariable, valueIndex: Int)?

    override func onSliderValueChanged(brewVariable: BrewVariable, valueIndex: Int) {
        valueChange = (brewVariable, valueIndex)
    }
}

class BrewVariableBundleCellTests: XCTestCase {

    private var viewModel: MockBrewVariableBundleCellVM!
    private var brewVariableBundleCell: BrewVariableBundleCell!

    override func setUp() {
        super.setUp()

        viewModel = MockBrewVariableBundleCellVM(
            variableBundle: MockBrewVars.tasteBundle,
            initialValues: MockBrewVars.tasteInitialValues
        )
        brewVariableBundleCell = BrewVariableBundleCell()
        brewVariableBundleCell.configure(viewModel: viewModel)
    }

    func testLabelText() {
        let expectedLabel = viewModel.sliderLabel

        XCTAssertEqual(expectedLabel, brewVariableBundleCell.cellView.label.text)
    }

    func testSliderCount() {
        let expectedSliderCount = viewModel.sliderVariables.count

        XCTAssertEqual(expectedSliderCount, brewVariableBundleCell.cellView.sliders.count)
    }

    func testSliderValueOnChange() {
        let variableIndex = 0
        let brewVariable = viewModel.sliderVariables[variableIndex]
        let value = brewVariable.stepCount - 1
        let expectedSliderValueChange = (brewVariable, value)

        let sliderValue = SliderValue(
            index: value,
            raw: Float(value) / Float(brewVariable.stepCount),
            text: "test"
        )
        let delegate = brewVariableBundleCell.cellView.sliders[variableIndex].delegate
        delegate!.onValueChanged(variable: brewVariable, to: sliderValue)

        XCTAssertEqual(expectedSliderValueChange.0, viewModel.valueChange!.0)
        XCTAssertEqual(expectedSliderValueChange.1, viewModel.valueChange!.1)
    }
}
