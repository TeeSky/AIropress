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
    
    static let cellIdentifier: String = {
        return "ConstantCellVM"
    }()
    
    var cellLabel: String {
        return constant.label
    }
    
    var cellValueText: String {
        return constant.valueText
    }
    
    private let constant: RecipeConstant
    
    init(constant: RecipeConstant) {
        self.constant = constant
    }
}

extension ConstantCellVM: BaseTableCellVM {
    
    var identifier: String {
        return ConstantCellVM.cellIdentifier
    }
    
    var cellHeight: CGFloat {
        return 35
    }
    
}
