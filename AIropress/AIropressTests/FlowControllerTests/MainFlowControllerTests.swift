//
//  MainFlowControllerTests.swift
//  AIropress
//
//  Created by Tomas Skypala on 16/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest


enum Scene {
    case desiredTaste
    case aiProcessing(brewParameters: BrewParameters)
    case viewRecipe(recipe: BrewRecipe)
}

protocol BaseNavigationController {
    func push(viewController: UIViewController)
    func pop()
}

protocol ViewControllerProvider {
    func getViewController(for scene: Scene) -> UIViewController
}

protocol DesiredTasteSceneFC {
    func onParametersSet(brewParameters: BrewParameters)
}

protocol AIProcessingSceneFC {
    func onProcessingDone(recipe: BrewRecipe)
}

protocol ViewRecipeSceneFC {
    func onRecipeReset()
    func onPrepared(recipe: BrewRecipe)
}

struct BrewParameters: Equatable {
    
}

struct BrewRecipe: Equatable {
    
}

class MainFlowController {
    
    let navigationController: BaseNavigationController
    let viewControllerProvider: ViewControllerProvider
    
    init(navigationController: BaseNavigationController, viewControllerProvider: ViewControllerProvider) {
        self.navigationController = navigationController
        self.viewControllerProvider = viewControllerProvider
    }
    
    func startFlow() {
        switchTo(scene: .desiredTaste)
    }
    
    func switchTo(scene: Scene) {
        let nextViewController = viewControllerProvider.getViewController(for: scene)
        navigationController.push(viewController: nextViewController)
    }
}

extension MainFlowController: DesiredTasteSceneFC {
    
    func onParametersSet(brewParameters: BrewParameters) {
        switchTo(scene: .aiProcessing(brewParameters: brewParameters))
    }
    
}

extension MainFlowController: AIProcessingSceneFC {
    
    func onProcessingDone(recipe: BrewRecipe) {
        navigationController.pop()
        
        switchTo(scene: .viewRecipe(recipe: recipe))
    }
}

extension MainFlowController: ViewRecipeSceneFC {
    
    func onRecipeReset() {
        navigationController.pop()
    }
    
    func onPrepared(recipe: BrewRecipe) {
        fatalError("not implemented")
    }
}

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
