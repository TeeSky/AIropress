//
//  MainFlowControllerTests.swift
//  AIropress
//
//  Created by Tomas Skypala on 16/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest


class MockViewControllerProvider: ViewControllerProvider {
    
    let desiredTasteSceneVC = UIViewController()
    let aiProcessingSceneVC = UIViewController()
    let viewRecipeSceneVC = UIViewController()
    
    var receivedBrewParameters: BrewParameters? = nil
    var receivedBrewRecipe: BrewRecipe? = nil
    
    func getViewController(for scene: Scene) -> UIViewController {
        switch (scene) {
        case .desiredTaste:
            return desiredTasteSceneVC
        case .aiProcessing(let parameters):
            receivedBrewParameters = parameters
            return aiProcessingSceneVC
        case .viewRecipe(let recipe):
            receivedBrewRecipe = recipe
            return viewRecipeSceneVC
        }
    }
}

class MockNavigationController: BaseNavigationController {
    
    var stack: [UIViewController] = []
    
    var didPush: Bool = false
    var didPop: Bool = false
    
    func push(viewController: UIViewController) {
        didPush = true
        stack.append(viewController)
    }
    
    func pop() {
        didPop = true
        _ = stack.popLast()
    }
    
    func resetPushPop() {
        didPush = false
        didPop = false
    }
}



class MainFlowControllerTests: XCTestCase {
    
    var navigationController: MockNavigationController!
    var viewControllerProvider: MockViewControllerProvider!
    
    var mainFlowController: MainFlowController!
    
    override func setUp() {
        super.setUp()
        self.continueAfterFailure = false
        
        navigationController = MockNavigationController()
        viewControllerProvider = MockViewControllerProvider()
        
        mainFlowController = MainFlowController(navigationController: navigationController, viewControllerProvider: viewControllerProvider)
    }
    
    func testInit() {
        let mainFlowController = MainFlowController(navigationController: navigationController, viewControllerProvider: viewControllerProvider)
        
        XCTAssertNotNil(mainFlowController.navigationController)
        XCTAssertNotNil(mainFlowController.viewControllerProvider)
    }
    
    func testSwitchToScene() {
        let expectedViewControllerOnStack = viewControllerProvider.desiredTasteSceneVC
        navigationController.resetPushPop()
        
        mainFlowController.switchTo(scene: .desiredTaste)
        
        XCTAssertFalse(navigationController.didPop)
        XCTAssertTrue(navigationController.didPush)
        XCTAssertEqual(expectedViewControllerOnStack, navigationController.stack[0])
    }
    
    func testStartFlow() {
        let expectedViewControllerOnStack = viewControllerProvider.desiredTasteSceneVC
        navigationController.resetPushPop()
        
        mainFlowController.startFlow()
        
        XCTAssertFalse(navigationController.didPop)
        XCTAssertTrue(navigationController.didPush)
        XCTAssertTrue(navigationController.stack.count == 1)
        XCTAssertEqual(expectedViewControllerOnStack, navigationController.stack[0])
    }

    func testDesiredTasteSceneFlowOnCalculate() {
        let expectedViewControllerOnStack = viewControllerProvider.aiProcessingSceneVC
        let brewParameters = BrewParameters()
        
        mainFlowController.startFlow()
        navigationController.resetPushPop()
        
        mainFlowController.onParametersSet(brewParameters: brewParameters)
        
        XCTAssertFalse(navigationController.didPop)
        XCTAssertTrue(navigationController.didPush)
        XCTAssertTrue(navigationController.stack.count == 2)
        XCTAssertEqual(expectedViewControllerOnStack, navigationController.stack[1])
        XCTAssertEqual(brewParameters, viewControllerProvider.receivedBrewParameters)
    }
    
    func testAIProcessingSceneFlowOnDone() {
        let expectedViewControllerOnStack = viewControllerProvider.viewRecipeSceneVC
        let recipe = BrewRecipe()
        
        mainFlowController.startFlow()
        mainFlowController.onParametersSet(brewParameters: BrewParameters())
        navigationController.resetPushPop()
        
        mainFlowController.onProcessingDone(recipe: recipe)
        
        XCTAssertTrue(navigationController.didPop)
        XCTAssertTrue(navigationController.didPush)
        XCTAssertTrue(navigationController.stack.count == 2)
        XCTAssertEqual(expectedViewControllerOnStack, navigationController.stack[1])
        XCTAssertEqual(recipe, viewControllerProvider.receivedBrewRecipe)
    }
    
    func testViewRecipeSceneFlowOnRecipeReset() {
        let expectedViewControllerOnStack = viewControllerProvider.desiredTasteSceneVC
        
        mainFlowController.startFlow()
        mainFlowController.onParametersSet(brewParameters: BrewParameters())
        mainFlowController.onProcessingDone(recipe: BrewRecipe())
        navigationController.resetPushPop()
        
        mainFlowController.onRecipeReset()
        
        XCTAssertTrue(navigationController.didPop)
        XCTAssertFalse(navigationController.didPush)
        XCTAssertTrue(navigationController.stack.count == 1)
        XCTAssertEqual(expectedViewControllerOnStack, navigationController.stack[0])
    }
    
    // TODO implement all flow control tests (when all scene fcs are done)
}