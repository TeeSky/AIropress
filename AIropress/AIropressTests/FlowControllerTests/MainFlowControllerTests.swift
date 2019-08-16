//
//  MainFlowControllerTests.swift
//  AIropress
//
//  Created by Skypy on 16/08/2019.
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
    func onCalculate(brewParameters: BrewParameters)
}

struct BrewParameters: Equatable {
    
}

struct BrewRecipe {
    
}

class MainFlowController {
    
    let navigationController: BaseNavigationController
    let viewControllerProvider: ViewControllerProvider
    
    init(navigationController: BaseNavigationController, viewControllerProvider: ViewControllerProvider) {
        self.navigationController = navigationController
        self.viewControllerProvider = viewControllerProvider
    }
    
    func startFlow() {
        let nextViewController = viewControllerProvider.getViewController(for: Scene.desiredTaste)
        navigationController.push(viewController: nextViewController)
    }
}

extension MainFlowController: DesiredTasteSceneFC {
    
    func onCalculate(brewParameters: BrewParameters) {
        navigationController.pop()
        let nextViewController = viewControllerProvider.getViewController(for: Scene.aiProcessing(brewParameters: brewParameters))
        navigationController.push(viewController: nextViewController)
    }
    
}

class MockViewControllerProvider: ViewControllerProvider {
    
    let scene1VC = UIViewController()
    let scene2VC = UIViewController()
    let scene3VC = UIViewController()
    
    var receivedBrewParameters: BrewParameters? = nil
    var receivedBrewRecipe: BrewRecipe? = nil
    
    func getViewController(for scene: Scene) -> UIViewController {
        switch (scene) {
        case .desiredTaste:
            return scene1VC
        case .aiProcessing(let parameters):
            receivedBrewParameters = parameters
            return scene2VC
        case .viewRecipe(let recipe):
            receivedBrewRecipe = recipe
            return scene3VC
        }
    }
}

class MockNavigationController: BaseNavigationController {
    
    var stack: [UIViewController] = []
    
    var didPop: Bool = false
    var didPush: Bool = false
    
    func push(viewController: UIViewController) {
        didPush = true
        stack.append(viewController)
    }
    
    func pop() {
        didPop = true
        _ = stack.popLast()
    }
    
    func resetPopPush() {
        didPop = false
        didPush = false
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
    
    func testStartFlow() {
        let expectedViewControllerOnStack = viewControllerProvider.scene1VC
        
        mainFlowController.startFlow()
        
        XCTAssertTrue(navigationController.stack.count == 1)
        XCTAssertEqual(expectedViewControllerOnStack, navigationController.stack[0])
    }

    func testDesiredTasteSceneFlowOnCalculate() {
        let expectedViewControllerOnStack = viewControllerProvider.scene2VC
        let brewParameters = BrewParameters()
        mainFlowController.startFlow()
        navigationController.resetPopPush()
        
        mainFlowController.onCalculate(brewParameters: brewParameters)
        
        XCTAssertTrue(navigationController.didPop)
        XCTAssertTrue(navigationController.didPush)
        XCTAssertTrue(navigationController.stack.count == 1)
        XCTAssertEqual(expectedViewControllerOnStack, navigationController.stack[0])
        XCTAssertEqual(brewParameters, viewControllerProvider.receivedBrewParameters)
    }
}
