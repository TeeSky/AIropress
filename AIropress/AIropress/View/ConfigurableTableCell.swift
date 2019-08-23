//
//  ConfigurableTableCell.swift
//  AIropress
//
//  Created by Tomas Skypala on 19/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

protocol ConfigurableTableCell {
    func configure(viewModel: BaseTableCellVM)
}
