//
//  ViewRecipeVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 22/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class ConstantCellVM {
    
    static let cellIdentifier: String = {
        return "BrewVariableBundleCellVM"
    }()
}

extension ConstantCellVM: BaseTableCellVM {
    
    var identifier: String {
        return ConstantCellVM.cellIdentifier
    }
    
    var cellHeight: CGFloat {
        return 25
    }
    
}

class ViewRecipeVM {
    
    let cellVMs: [BaseTableCellVM]
    
    init(brewRecipe: BrewRecipe) {
        self.cellVMs = []
    }
}

extension ViewRecipeVM: BaseTableVM {
    
    func numberOfSections() -> Int {
        return 0
    }
    
    func numberOfRows(section: Int) -> Int {
        return 0
    }
    
    func cellViewModel(for path: IndexPath) -> BaseTableCellVM {
        return ConstantCellVM()
    }
    
    func cellHeight(for path: IndexPath) -> CGFloat {
        return 0
    }
    
}

class ViewRecipeVMTests: XCTestCase {

    var recipe: BrewRecipe!
    
    var viewRecipeVM: ViewRecipeVM!
    
    override func setUp() {
        super.setUp()
        
        recipe = BrewRecipe()
        viewRecipeVM = ViewRecipeVM(brewRecipe: recipe)
    }
    
    func testInit() {
        XCTAssertNotNil(viewRecipeVM)
    }

}
