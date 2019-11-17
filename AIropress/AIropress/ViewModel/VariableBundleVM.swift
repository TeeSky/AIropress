//
//  VariableBundleVM.swift
//  AIropress
//
//  Created by Tomas Skypala on 17/11/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

class VariableBundleVM {

    private(set) var cellVMs: [BrewVariableBundleCellVM]
    let brewParameters: BrewParameters

    init(brewVariableBundles: [BrewVariableBundle], values: [BrewVariable.Id: Double?] = [:]) {
        brewParameters = BrewParameters(brewVariableBundles: brewVariableBundles, values: values)
        cellVMs = []

        setupCellVMs(brewVariableBundles: brewVariableBundles)
    }

    func configure(tableView: UITableView) {
        tableView.register(BrewVariableBundleCell.self, forCellReuseIdentifier: BrewVariableBundleCellVM.cellIdentifier)
    }

    private func setupCellVMs(brewVariableBundles: [BrewVariableBundle]) {
        for variableBundle in brewVariableBundles {
            let initialValues = variableBundle.variables
                .reduce([BrewVariable: Double]()) { (dict, variable) -> [BrewVariable: Double] in
                    var dict = dict
                    dict[variable] = brewParameters.valueMap[variable.id]
                    return dict
                }

            let vm = BrewVariableBundleCellVM(variableBundle: variableBundle, initialValues: initialValues)
            vm.valueDelegate = self
            cellVMs.append(vm)
        }
    }
}

extension VariableBundleVM: VariableBundleCellValueDelegate {

    func onValueChanged(brewVariable: BrewVariable, value: Double) {
        brewParameters.valueMap[brewVariable.id] = value
    }
}

extension VariableBundleVM: BaseTableVM {

    var cellViewModels: [BaseTableCellVM] {
        return cellVMs
    }
}
