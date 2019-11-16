//
//  BaseViewModel.swift
//  AIropress
//
//  Created by Tomas Skypala on 18/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import CoreGraphics
import Foundation

/**
 A common base view model type.
 */
protocol BaseViewModel {}

/**
 Base **UITableViewCell** view model type.
 */
protocol BaseTableCellVM {

    /**
     Cell's reuse identifier.
     */
    var identifier: String { get }

    /**
     Cell's height within the **UITableView**.
     */
    var cellHeight: CGFloat { get }
}

/**
 Base **UITableView** view model type.
 */
protocol BaseTableVM: BaseViewModel {
    var cellViewModels: [BaseTableCellVM] { get }
}

extension BaseTableVM {

    /**
     Returns total number of sections.

     - Warning: Currently only single section table views are supported,
     this fuction therefore always returns 1.

     - Returns: Total number of sections.
     */
    func numberOfSections() -> Int {
        return 1
    }

    /**
     Returns total number of rows within specified section.

     - Warning: Currently only single section table views are supported,
     section parameters must always be "0", otherwise fatalError will be thrown.

     - Parameter section: Index of the section

     - Returns: Total number of rows within the section.
     */
    func numberOfRows(section: Int) -> Int {
        guard section == 0 else { fatalError("Unexpected section") }

        return cellViewModels.count
    }

    /**
     Retrieves view model for specified **IndexPath**.

     - Warning: Currently only single section table views are supported,
     section parameter of the path must always be "0", otherwise fatalError
     will be thrown.

     - Parameter path: Path of the cell

     - Returns: Cell view model belonging to the path.
     */
    func cellViewModel(for path: IndexPath) -> BaseTableCellVM {
        guard path.section == 0 else { fatalError("Unexpected section") }

        return cellViewModels[path.row]
    }

    /**
     Returns view height for cell at specified **IndexPath**.

     - Warning: Currently only single section table views are supported,
     section parameter of the path must always be "0", otherwise fatalError
     will be thrown.

     - Parameter path: Path of the cell

     - Returns: View height of cell belonging to the path.
     */
    func cellHeight(for path: IndexPath) -> CGFloat {
        return cellViewModel(for: path).cellHeight
    }
}
