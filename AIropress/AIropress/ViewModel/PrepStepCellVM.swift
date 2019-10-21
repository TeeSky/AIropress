//
//  PrepStepCellVM.swift
//  AIropress
//
//  Created by Tomas Skypala on 30/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import CoreGraphics

class PrepStepCellVM {

    static let cellIdentifier: String = {
        return "ConstantCellVM"
    }()

    static let cellHeight: CGFloat = {
        return 60
    }()

    let cellText: String

    init(cellIndex: Int, prepStep: PrepStep) {
        self.cellText = "\(cellIndex + 1). \(prepStep.text())"
    }
}

extension PrepStepCellVM: BaseTableCellVM {

    var identifier: String {
        return PrepStepCellVM.cellIdentifier
    }

    var cellHeight: CGFloat {
        return PrepStepCellVM.cellHeight
    }

}
