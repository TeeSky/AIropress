//
//  BrewPrepVM.swift
//  AIropress
//
//  Created by Tomas Skypala on 30/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

class BrewPrepVM {
    
    let cellVMs: [PrepStepCellVM]
    
    weak var flowController: BrewPrepSceneFC?
    
    init(prepParams: PrepParams) {
        cellVMs = prepParams.prepSteps.enumerated().map { PrepStepCellVM(cellIndex: $0, prepStep: $1)}
    }
    
    func onBrewClicked() {
        flowController?.onBrewInitiated()
    }
}

extension BrewPrepVM: BaseTableVM {
    
    var cellViewModels: [BaseTableCellVM] {
        return cellVMs
    }
    
}
