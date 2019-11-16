//
//  SemiConstantCellVM.swift
//  AIropress
//
//  Created by Tomas Skypala on 22/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import CoreGraphics
import Foundation

class SemiConstantCellVM: ConstantCellVM {

    override class var cellIdentifier: String {
        return "SemiConstantCellVM"
    }

    static let cellHeight: CGFloat = {
        let labelHeight = 35
        let sliderHeight = BrewVariableSlider.height
        return CGFloat(labelHeight + sliderHeight)
    }()

    var confidenceVariable: BrewVariable {
        return variable
    }

    var confidenceValue: Double {
        return changedConfidenceValue ?? initialConfidenceValue
    }

    private let variable: BrewVariable

    private let initialConfidenceValue: Double

    private var changedConfidenceValue: Double?

    convenience init?(semiConstant: RecipeSemiConstant) {
        guard let stringifier = semiConstant.constant.stringifier else { return nil }

        self.init(
            stringifier: stringifier,
            constantId: semiConstant.constant.id,
            constantValue: semiConstant.constant.value,
            confidenceVariable: semiConstant.confidenceVariable,
            confidenceValue: semiConstant.confidenceValue
        )
    }

    init(
        stringifier: ValueStringifier,
        constantId: Int,
        constantValue: Double,
        confidenceVariable: BrewVariable,
        confidenceValue: Double
    ) {
        variable = confidenceVariable
        initialConfidenceValue = confidenceValue

        super.init(stringifier: stringifier, constantId: constantId, constantValue: constantValue)
    }

    func onSliderValueChanged(to value: Float) {
        changedConfidenceValue = Double(value)
    }
}

extension SemiConstantCellVM: BrewVariableSliderDelegate {

    func onValueChanged(variable _: BrewVariable, to value: SliderValue) {
        onSliderValueChanged(to: value.raw)
    }
}

extension SemiConstantCellVM {

    override var identifier: String {
        return SemiConstantCellVM.cellIdentifier
    }

    override var cellHeight: CGFloat {
        return SemiConstantCellVM.cellHeight
    }
}
