//
//  BaseTableVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 14/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class MockTableCellVM: BaseTableCellVM {
    var identifier: String {
        return "MockTableCellVM"
    }
    var cellHeight: CGFloat {
        return CGFloat(id + 10)
    }
    
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    static func expectedCellHeight(cellId: Int) -> CGFloat {
        return CGFloat(cellId + 10)
    }
}

class MockTableVM: BaseTableVM {
    
    var cellViewModels: [BaseTableCellVM]
    
    init(cellViewModels: [BaseTableCellVM]) {
        self.cellViewModels = cellViewModels
    }
}

class BaseTableVMTests: XCTestCase {

    var cellViewModels: [MockTableCellVM]!
    
    var baseTableVM: MockTableVM!
    
    override func setUp() {
        super.setUp()
        
        cellViewModels = Array(35...50).map { MockTableCellVM(id: $0) }
        baseTableVM = MockTableVM(cellViewModels: cellViewModels)
    }
    
    func testNumberOfSections() {
        let expectedNumberOfSections = 1
        
        XCTAssertEqual(expectedNumberOfSections, baseTableVM.numberOfSections())
    }

    func testNumberOfRows() {
        let expectedNumberOfRowsInSection1 = cellViewModels.count
        
        XCTAssertEqual(expectedNumberOfRowsInSection1, baseTableVM.numberOfRows(section: 0))
    }
    
    func testCellViewModelForPath() {
        for (i, cellVm) in cellViewModels.enumerated() {
            let indexPath = IndexPath(row: i, section: 0)
            let expectedCellIndex = cellVm.id
            
            let cell = baseTableVM.cellViewModel(for: indexPath) as? MockTableCellVM
            
            XCTAssertEqual(expectedCellIndex, cell?.id)
        }
    }
    
    func testCellHeightForPath() {
        for (i, cellVm) in cellViewModels.enumerated() {
            let indexPath = IndexPath(row: i, section: 0)
            let expectedCellHeight = MockTableCellVM.expectedCellHeight(cellId: cellVm.id)
            
            let cellHeight = baseTableVM.cellHeight(for: indexPath)
            
            XCTAssertEqual(expectedCellHeight, cellHeight)
        }
    }
//
//    func cellHeight(for path: IndexPath) -> CGFloat {
//        return cellViewModel(for: path).cellHeight
//    }
}
