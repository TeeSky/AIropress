//
//  ConstantCellVM.swift
//  AIropress
//
//  Created by Tomas Skypala on 22/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import CoreGraphics

class ConstantCellVM {
    
    class var cellIdentifier: String {
        return "ConstantCellVM"
    }
    
    var cellLabelText: String {
        return labelText
    }
    
    var cellValueText: String {
        return valueText
    }
    
    private let labelText: String
    private let valueText: String
    
    let constantId: Int
    let constantValue: Double
    
    convenience init?(constant: RecipeConstant) {
        guard let stringifier = constant.stringifier else { return nil }
        
        self.init(stringifier: stringifier, constantId: constant.id, constantValue: constant.value)
    }
    
    init(stringifier: ValueStringifier, constantId: Int, constantValue: Double) {
        self.labelText = stringifier.labelText()
        self.valueText = stringifier.toString(value: constantValue)
        
        self.constantId = constantId
        self.constantValue = constantValue
    }
}

extension ConstantCellVM: BaseTableCellVM {
    
    @objc
    var identifier: String {
        return ConstantCellVM.cellIdentifier
    }
    
    @objc
    var cellHeight: CGFloat {
        return 35
    }
    
}
