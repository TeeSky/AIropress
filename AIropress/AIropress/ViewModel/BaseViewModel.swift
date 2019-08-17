//
//  BaseViewModel.swift
//  AIropress
//
//  Created by Tomas Skypala on 18/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation


protocol BaseViewModel {
}

protocol BaseTableCellVM {
    var identifier: String { get }
}

protocol BaseTableVM: BaseViewModel {
    func numberOfSections() -> Int
    func numberOfRows(section: Int) -> Int
    func cellViewModel(for path: IndexPath) -> BaseTableCellVM
}
