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
    func numberOfSections() -> Int
    func numberOfRows(section: Int) -> Int
    func cellViewModel(for path: IndexPath) -> BaseTableCellVM
    func cellHeight(for path: IndexPath) -> CGFloat
}
