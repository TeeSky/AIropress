//
//  PrepStepCell.swift
//  AIropress
//
//  Created by Tomas Skypala on 04/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

class PrepStepCell: BaseTableViewCell<PrepStepCellView> {
    
}

extension PrepStepCell: ConfigurableTableCell {
    
    func configure(viewModel: BaseTableCellVM) {
        guard let prepStepCellVm = viewModel as? PrepStepCellVM else { fatalError("Unexpected view model type.") }
        
        cellView.textView.text = prepStepCellVm.cellText
        
        self.updateConstraints()
    }
    
}
