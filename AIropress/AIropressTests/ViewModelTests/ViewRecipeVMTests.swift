//
//  ViewRecipeVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 22/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class ViewRecipeVM {
    
    weak var flowController: ViewRecipeSceneFC?
    
    private(set) var cellVMs: [BaseTableCellVM]
    
    let brewRecipeConstants: [RecipeConstant]
    
    init(brewRecipe: BrewRecipe) {
        self.brewRecipeConstants = brewRecipe.constants
        self.cellVMs = []
        
        setupCellVMs(brewRecipe: brewRecipe)
    }
    
    func onResetClicked() {
        flowController?.onRecipeReset()
    }
    
    func onPrepareClicked() {
        var recipeValues = brewRecipeConstants.reduce(into: [Int: Double]()) { $0[$1.id] = $1.value }
        
//        for vm in cellVMs where let semiConstantCellVM = vm as? SemiConstantCellVM {
        for vm in cellVMs {
            guard let semiConstantCellVM = vm as? SemiConstantCellVM else { continue }
            
            recipeValues[semiConstantCellVM.recipeConstant.id] = semiConstantCellVM.recipeConstant.value
            recipeValues[semiConstantCellVM.confidenceVariable.id] = semiConstantCellVM.confidenceValue
        }
        
        flowController?.onPrepared(recipeValues: recipeValues)
    }
    
    private func setupCellVMs(brewRecipe: BrewRecipe) {
        cellVMs.append(contentsOf: brewRecipe.constants.map { ConstantCellVM(constant: $0) })
        cellVMs.append(contentsOf: brewRecipe.semiConstants.map { SemiConstantCellVM(semiConstant: $0) })
    }
    
}

private class MockViewRecipeSceneFC: ViewRecipeSceneFC {
    
    var recipeReset: Bool?
    var recipeValues: [Int : Double]?
    
    func onRecipeReset() {
        recipeReset = true
    }
    
    func onPrepared(recipeValues: [Int : Double]) {
        self.recipeValues = recipeValues
    }
    
}

extension ViewRecipeVM: BaseTableVM {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(section: Int) -> Int {
        guard section == 0 else { fatalError("Unexpected section") }
        
        return cellVMs.count
    }
    
    func cellViewModel(for path: IndexPath) -> BaseTableCellVM {
        guard path.section == 0 else { fatalError("Unexpected section") }
        return cellVMs[path.row]
    }
    
    func cellHeight(for path: IndexPath) -> CGFloat {
        return cellViewModel(for: path).cellHeight
    }
    
}

class ViewRecipeVMTests: XCTestCase {

    var recipe: BrewRecipe!
    
    var viewRecipeVM: ViewRecipeVM!
    
    override func setUp() {
        super.setUp()
        
        recipe = MockBrewVars.recipe
        viewRecipeVM = ViewRecipeVM(brewRecipe: recipe)
    }
    
    func testInit() {
        XCTAssertEqual(recipe.constants, viewRecipeVM.brewRecipeConstants)
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(1, viewRecipeVM.numberOfSections())
    }
    
    func testNumberOfRows() {
        let expectedNumberOfRows = recipe.constants.count + recipe.semiConstants.count
        
        XCTAssertEqual(expectedNumberOfRows, viewRecipeVM.numberOfRows(section: 0))
    }

    func testCellViewModelForPathConstantCellVMs() {
        for (index, recipeConstant) in recipe.constants.enumerated() {
            let viewModel = viewRecipeVM.cellViewModel(for: IndexPath(row: index, section: 0))
            let expectedLabel = recipeConstant.label
            let expectedValueText = recipeConstant.valueText
            
            XCTAssertNotNil(viewModel as? ConstantCellVM)
            XCTAssertEqual(expectedLabel, (viewModel as! ConstantCellVM).cellLabel)
            XCTAssertEqual(expectedValueText, (viewModel as! ConstantCellVM).cellValueText)
        }
    }
    
    func testCellViewModelForPathSemiConstantCellVM() {
        let indexOffset = recipe.constants.count
        for (index, recipeSemiConstant) in recipe.semiConstants.enumerated() {
            let viewModel = viewRecipeVM.cellViewModel(for: IndexPath(row: index + indexOffset, section: 0))
            let expectedLabel = recipeSemiConstant.constant.label
            let expectedValueText = recipeSemiConstant.constant.valueText
            let expectedConfidenceVariable = recipeSemiConstant.confidenceVariable
            
            XCTAssertNotNil(viewModel as? SemiConstantCellVM)
            XCTAssertEqual(expectedLabel, (viewModel as! SemiConstantCellVM).cellLabel)
            XCTAssertEqual(expectedValueText, (viewModel as! SemiConstantCellVM).cellValueText)
            XCTAssertEqual(expectedConfidenceVariable, (viewModel as! SemiConstantCellVM).confidenceVariable)
        }
    }
    
    func testHeightForPathConstantCellVM() {
        let cell0IndexPath = IndexPath(row: 0, section: 0)
        let cell0VM = viewRecipeVM.cellVMs[cell0IndexPath.row]
        XCTAssertNotNil(cell0VM as? ConstantCellVM) // Sanity check
        let expectedCell0Height = cell0VM.cellHeight
        
        let actualCell0Height = viewRecipeVM.cellHeight(for: cell0IndexPath)
        
        XCTAssertEqual(expectedCell0Height, actualCell0Height)
    }
    
    func testHeightForPathSemiConstantCellVM() {
        let cell4IndexPath = IndexPath(row: 3, section: 0)
        let cell4VM = viewRecipeVM.cellVMs[cell4IndexPath.row]
        XCTAssertNotNil(cell4VM as? SemiConstantCellVM) // Sanity check
        let expectedCell4Height = cell4VM.cellHeight
        
        let actualCell4Height = viewRecipeVM.cellHeight(for: cell4IndexPath)
        
        XCTAssertEqual(expectedCell4Height, actualCell4Height)
    }
    
    func testOnResetClicked() {
        let flowController = MockViewRecipeSceneFC()
        viewRecipeVM.flowController = flowController
        let expectedRecipeReset = true
        
        viewRecipeVM.onResetClicked()
        
        XCTAssertEqual(expectedRecipeReset, flowController.recipeReset)
    }
    
    func testOnPrepareClicked() {
        let flowController = MockViewRecipeSceneFC()
        viewRecipeVM.flowController = flowController
        let expectedValueCount = recipe.constants.count + (recipe.semiConstants.count * 2)
        
        viewRecipeVM.onPrepareClicked()
        
        let outputValues = flowController.recipeValues
        XCTAssertEqual(expectedValueCount, outputValues?.count)
        for constant in recipe.constants {
            let expectedValue = constant.value
            
            XCTAssertEqual(expectedValue, outputValues?[constant.id])
        }
        for semiConstant in recipe.semiConstants {
            let expectedConstantValue = semiConstant.constant.value
            let expectedConfidenceValue = semiConstant.confidenceValue
            
            XCTAssertEqual(expectedConstantValue, outputValues?[semiConstant.constant.id])
            XCTAssertEqual(expectedConfidenceValue, outputValues?[semiConstant.confidenceVariable.id])
        }
    }
}
