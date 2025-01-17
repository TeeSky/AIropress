//
//  BrewVariableBundleCell.swift
//  AIropress
//
//  Created by Tomas Skypala on 19/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

class BrewVariableBundleCell: BaseTableViewCell<BrewVariableBundleCellView> {

}

extension BrewVariableBundleCell: ConfigurableTableCell {

    func configure(viewModel: BaseTableCellVM) {
        guard let viewModel = viewModel as? BrewVariableBundleCellVM else { fatalError("Unexpected view model type.") }

        setupLabel(viewModel: viewModel)
        setupSliders(viewModel: viewModel)

        didSetConstraints = false
        self.updateConstraints()
    }

    private func setupLabel(viewModel: BrewVariableBundleCellVM) {
        cellView.label.text = viewModel.sliderLabel
    }

    private func setupSliders(viewModel: BrewVariableBundleCellVM) {
        cellView.sliders = []
        for variable in viewModel.sliderVariables {
            let slider = BrewVariableSlider()
            slider.configure(brewVariable: variable, initialValue: viewModel.initialSliderValue(for: variable))
            slider.delegate = viewModel

            cellView.sliders.append(slider)
            cellView.slidersContainer.addSubview(slider)
        }
    }
}
