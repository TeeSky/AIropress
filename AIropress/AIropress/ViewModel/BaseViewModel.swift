//
//  BaseViewModel.swift
//  AIropress
//
//  Created by Tomas Skypala on 18/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import CoreGraphics

protocol BaseViewModel {
}

protocol BaseTableCellVM {
    var identifier: String { get }
    var cellHeight: CGFloat { get }
}

protocol BaseTableVM: BaseViewModel {
    var cellViewModels: [BaseTableCellVM] { get }
}

extension BaseTableVM {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(section: Int) -> Int {
        guard section == 0 else { fatalError("Unexpected section") }
        
        return cellViewModels.count
    }
    
    func cellViewModel(for path: IndexPath) -> BaseTableCellVM {
        guard path.section == 0 else { fatalError("Unexpected section") }
        
        return cellViewModels[path.row]
    }
    
    func cellHeight(for path: IndexPath) -> CGFloat {
        return cellViewModel(for: path).cellHeight
    }
    
}
