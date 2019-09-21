//
//  BrewVariableBundleCellVM.swift
//  AIropress
//
//  Created by Tomas Skypala on 18/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import CoreGraphics

protocol VariableBundleCellValueDelegate: class {
    func onValueChanged(brewVariable: BrewVariable, value: Double)
}

class BrewVariableBundleCellVM {

    static let cellIdentifier: String = {
        return "BrewVariableBundleCellVM"
    }()

    var sliderLabel: String {
        return variableBundle.label
    }

    var sliderVariables: [BrewVariable] {
        return variableBundle.variables
    }

    private let variableBundle: BrewVariableBundle
    private var currentValues: [BrewVariable: Double]

    weak var valueDelegate: VariableBundleCellValueDelegate?

    init(variableBundle: BrewVariableBundle, initialValues: [BrewVariable: Double]) {
        self.variableBundle = variableBundle
        self.currentValues = initialValues
    }

    func onSliderValueChanged(brewVariable: BrewVariable, valueIndex: Int) {
        let normalizedValue = normalize(sliderValueIndex: valueIndex, of: brewVariable)

        currentValues[brewVariable] = normalizedValue
        valueDelegate?.onValueChanged(brewVariable: brewVariable, value: normalizedValue)
    }

    func initialSliderValue(for variable: BrewVariable) -> Float {
        guard let value = currentValues[variable] else { fatalError("Brew variable initial values must be set.") }
        return Float(value)
    }

    private func normalize(sliderValueIndex: Int, of brewVariable: BrewVariable) -> Double {
        return Double(sliderValueIndex + 1) / Double(brewVariable.stepCount)
    }
}

extension BrewVariableBundleCellVM: BaseTableCellVM {

    var identifier: String {
        return BrewVariableBundleCellVM.cellIdentifier
    }

    var cellHeight: CGFloat {
        let labelHeight = 55
        let slidersHeight = variableBundle.variables.count * BrewVariableSlider.height
        return CGFloat(labelHeight + slidersHeight)
    }
}
