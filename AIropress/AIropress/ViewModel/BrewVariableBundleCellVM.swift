//
//  BrewVariableBundleCellVM.swift
//  AIropress
//
//  Created by Skypy on 18/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation


protocol VariableBundleCellValueDelegate: class {
    func onValueChanged(brewVariable: BrewVariable, value: Double)
}

class BrewVariableBundleCellVM {
    
    static let cellIdentifier: String = {
        return "BrewVariableBundleCellVM"
    }()
    
    let variableBundle: BrewVariableBundle
    
    weak var valueDelegate: VariableBundleCellValueDelegate?
    
    init(variableBundle: BrewVariableBundle) {
        self.variableBundle = variableBundle
    }
    
    func onSliderValueChanged(brewVariable: BrewVariable, valueIndex: Int) {
        let normalizedValue = normalize(sliderValueIndex: valueIndex, of: brewVariable)
        
        valueDelegate?.onValueChanged(brewVariable: brewVariable, value: normalizedValue)
    }
    
    private func normalize(sliderValueIndex: Int, of brewVariable: BrewVariable) -> Double {
        return Double(sliderValueIndex + 1) / Double(brewVariable.stepCount)
    }
}

extension BrewVariableBundleCellVM: BaseTableCellVM {
    
    var identifier: String {
        return BrewVariableBundleCellVM.cellIdentifier
    }
}
