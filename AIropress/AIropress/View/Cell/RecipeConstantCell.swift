//
//  RecipeConstantCell.swift
//  AIropress
//
//  Created by Tomas Skypala on 23/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

class RecipeConstantCell: BaseTableViewCell<RecipeConstantCellView> {
    
}

extension RecipeConstantCell: ConfigurableTableCell {
    
    func configure(viewModel: BaseTableCellVM) {
        guard let viewModel = viewModel as? ConstantCellVM else { fatalError("Unexpected view model type.") }
        
        cellView.constantLabel.text = viewModel.cellLabel
        cellView.constantValue.text = viewModel.cellValueText
        
        didSetConstraints = false
        self.updateConstraints()
    }
}
