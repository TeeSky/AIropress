//
//  BrewPrepVM.swift
//  AIropress
//
//  Created by Tomas Skypala on 30/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

class BrewPrepVM {
    
    let cellVMs: [PrepStepCellVM]
    
    weak var flowController: BrewPrepSceneFC?
    
    init(prepParams: PrepParams) {
        cellVMs = prepParams.prepSteps.enumerated().map { PrepStepCellVM(cellIndex: $0, prepStep: $1)}
    }
    
    func configure(tableView: UITableView) {
        tableView.register(PrepStepCell.self, forCellReuseIdentifier: PrepStepCellVM.cellIdentifier)
    }
    
    @objc
    func onBrewClicked() {
        flowController?.onBrewInitiated()
    }
    
    @objc
    func onResetClicked() {
        flowController?.onBrewPrepReset()
    }
}

extension BrewPrepVM: BaseTableVM {
    
    var cellViewModels: [BaseTableCellVM] {
        return cellVMs
    }
    
}
