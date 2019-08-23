//
//  SemiConstantCellVM.swift
//  AIropress
//
//  Created by Tomas Skypala on 22/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import CoreGraphics

class SemiConstantCellVM {
    
    static let cellIdentifier: String = {
        return "SemiConstantCellVM"
    }()
    
    static let cellHeight: CGFloat = {
        let labelHeight = 35
        let sliderHeight = BrewVariableSlider.height
        return CGFloat(labelHeight + sliderHeight)
    }()
    
    var cellLabel: String {
        return recipeConstant.label
    }
    
    var cellValueText: String {
        return recipeConstant.valueText
    }
    
    var recipeConstant: RecipeConstant {
        return semiConstant.constant
    }
    
    var confidenceVariable: BrewVariable {
        return semiConstant.confidenceVariable
    }
    
    var confidenceValue: Double {
        return changedConfidenceValue ?? semiConstant.confidenceValue
    }
    
    private let semiConstant: RecipeSemiConstant
    private var changedConfidenceValue: Double?
    
    init(semiConstant: RecipeSemiConstant) {
        self.semiConstant = semiConstant
    }
    
    func onSliderValueChanged(to value: Float) {
        changedConfidenceValue = Double(value)
    }
}

extension SemiConstantCellVM: BaseTableCellVM {
    
    var identifier: String {
        return SemiConstantCellVM.cellIdentifier
    }
    
    var cellHeight: CGFloat {
        return SemiConstantCellVM.cellHeight
    }
    
}
