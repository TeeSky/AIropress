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
        for variableBundle in brewVariableBundles {
            let vm = BrewVariableBundleCellVM(variableBundle: variableBundle)
            vm.valueDelegate = self
            cellVMs.append(vm)
        }
    }
    
    func configure(tableView: UITableView) {
        tableView.register(BrewVariableBundleCell.self, forCellReuseIdentifier: BrewVariableBundleCellVM.cellIdentifier)
    }
    
    func onCalculateClicked() {
        flowController?.onParametersSet(brewParameters: brewParameters)
    }
}

extension DesiredTasteVM: VariableBundleCellValueDelegate {
    
    func onValueChanged(brewVariable: BrewVariable, value: Double) {
        brewParameters.valueMap[brewVariable.id] = value
    }
    
}

extension DesiredTasteVM: BaseTableVM {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(section: Int) -> Int {
        guard section == 0 else { fatalError("Unexpected section") }
        
        return cellVMs.count
    }
    
    func cellViewModel(for path: IndexPath) -> BaseTableCellVM {
        guard path.section == 0 else { fatalError("Unexpected section") }
        
        return cellVMs[path.row]
    }
    
    func cellHeight(for path: IndexPath) -> CGFloat {
        return cellViewModel(for: path).cellHeight
    }
    
    
}
