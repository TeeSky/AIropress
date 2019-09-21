//
//  DesiredTasteVM.swift
//  AIropress
//
//  Created by Tomas Skypala on 18/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

class DesiredTasteVM {

    private(set) var cellVMs: [BrewVariableBundleCellVM]
    let brewParameters: BrewParameters

    weak var flowController: DesiredTasteSceneFC?

    init(brewVariableBundles: [BrewVariableBundle], values: [BrewVariable.Id: Double?] = [:]) {
        self.brewParameters = BrewParameters(brewVariableBundles: brewVariableBundles, values: values)
        self.cellVMs = []

        setupCellVMs(brewVariableBundles: brewVariableBundles)
    }

    func configure(tableView: UITableView) {
        tableView.register(BrewVariableBundleCell.self, forCellReuseIdentifier: BrewVariableBundleCellVM.cellIdentifier)
    }

    @objc
    func onCalculateClicked() {
        flowController?.onParametersSet(brewParameters: brewParameters)
    }

    private func setupCellVMs(brewVariableBundles: [BrewVariableBundle]) {
        for variableBundle in brewVariableBundles {
            //            var initialValues: [BrewVariable: Double] = variableBundle.variables.reduce([:]) { $0[$1] = brewParameters.valueMap[$1.id] }
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

extension DesiredTasteVM: VariableBundleCellValueDelegate {

    func onValueChanged(brewVariable: BrewVariable, value: Double) {
        brewParameters.valueMap[brewVariable.id] = value
    }

}

extension DesiredTasteVM: BaseTableVM {

    var cellViewModels: [BaseTableCellVM] {
        return self.cellVMs
    }

}
