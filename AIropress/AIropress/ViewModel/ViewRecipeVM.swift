//
//  ViewRecipeVM.swift
//  AIropress
//
//  Created by Tomas Skypala on 23/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

class ViewRecipeVM {

    weak var flowController: ViewRecipeSceneFC?

    private(set) var cellVMs: [BaseTableCellVM]
    private(set) var hiddenValues: [Int: Double]

    init(brewRecipe: BrewRecipe) {
        self.cellVMs = []
        self.hiddenValues = [:]

        setupCellVMs(brewRecipe: brewRecipe)
    }

    func configure(tableView: UITableView) {
        tableView.register(RecipeConstantCell.self, forCellReuseIdentifier: ConstantCellVM.cellIdentifier)
        tableView.register(RecipeSemiConstantCell.self, forCellReuseIdentifier: SemiConstantCellVM.cellIdentifier)
    }

    @objc
    func onResetClicked() {
        flowController?.onViewRecipeReset()
    }

    @objc
    func onPrepareClicked() {
        var recipeValues = cellVMs.reduce(into: [Int: Double]()) { dict, vm in
            switch vm {
            case let vm as SemiConstantCellVM:
                dict[vm.constantId] = vm.constantValue
                dict[vm.confidenceVariable.id] = vm.confidenceValue
            case let vm as ConstantCellVM:
                dict[vm.constantId] = vm.constantValue
            default:
                fatalError("Unexpected cellVM type.")
            }
        }
        recipeValues.merge(dict: hiddenValues)

        flowController?.onPrepared(recipeValues: recipeValues)
    }

    private func setupCellVMs(brewRecipe: BrewRecipe) {
        cellVMs.append(contentsOf: brewRecipe.constants.compactMap { constant in
            guard let vm = ConstantCellVM(constant: constant) else {
                hiddenValues[constant.id] = constant.value
                return nil
            }
            return vm
        })

        cellVMs.append(contentsOf: brewRecipe.semiConstants.compactMap { semiConstant in
            guard let vm = SemiConstantCellVM(semiConstant: semiConstant) else {
                hiddenValues[semiConstant.constant.id] = semiConstant.constant.value
                hiddenValues[semiConstant.confidenceVariable.id] = semiConstant.confidenceValue
                return nil
            }
            return vm
        })
    }
}

extension ViewRecipeVM: BaseTableVM {

    var cellViewModels: [BaseTableCellVM] {
        return self.cellVMs
    }
}
