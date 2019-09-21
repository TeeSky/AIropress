//
//  RecipeSemiConstantCell.swift
//  AIropress
//
//  Created by Tomas Skypala on 23/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

class RecipeSemiConstantCell: BaseTableViewCell<RecipeSemiConstantCellView> {

}

extension RecipeSemiConstantCell: ConfigurableTableCell {

    func configure(viewModel: BaseTableCellVM) {
        guard let viewModel = viewModel as? SemiConstantCellVM else {
            fatalError("Unexpected view model type.")
        }

        setupConstantView(viewModel: viewModel)
        setupConfidenceSlider(viewModel: viewModel)

        didSetConstraints = false
        self.updateConstraints()
    }

    private func setupConstantView(viewModel: SemiConstantCellVM) {
        cellView.constantView.constantLabel.text = viewModel.cellLabelText
        cellView.constantView.constantValue.text = viewModel.cellValueText
    }

    private func setupConfidenceSlider(viewModel: SemiConstantCellVM) {
        cellView.confidenceSlider.configure(brewVariable: viewModel.confidenceVariable,
                                            initialValue: Float(viewModel.confidenceValue))
        cellView.confidenceSlider.delegate = { sliderValue in
            viewModel.onSliderValueChanged(to: sliderValue.raw)
        }
    }
}
