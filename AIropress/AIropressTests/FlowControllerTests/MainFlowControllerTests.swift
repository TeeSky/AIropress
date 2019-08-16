//
//  MainFlowControllerTests.swift
//  AIropress
//
//  Created by Skypy on 16/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest


protocol BaseNavigationController {
    func push(viewController: UIViewController)
    func pop()
}

protocol ViewControllerProvider {
    func getViewController(forScene index: Int) -> UIViewController
}

class MainFlowController {
    
    let navigationController: BaseNavigationController
    let viewControllerProvider: ViewControllerProvider
    
    init(navigationController: BaseNavigationController, viewControllerProvider: ViewControllerProvider) {
        self.navigationController = navigationController
        self.viewControllerProvider = viewControllerProvider
    }
    
    func startFlow() {
        navigationController.push(viewController: viewControllerProvider.getViewController(forScene: 0))
    }
}

class MockViewControllerProvider: ViewControllerProvider {
    
    let scene1VC = UIViewController()
    let scene2VC = UIViewController()
    let scene3VC = UIViewController()
    
    let sceneControllers: [UIViewController]
    
    init() {
        sceneControllers = [scene1VC, scene2VC, scene3VC]
    }
    
    func getViewController(forScene index: Int) -> UIViewController {
        return sceneControllers[index]
    }
}

class MockNavigationController: BaseNavigationController {
    
    var stack: [UIViewController] = []
    
    func push(viewController: UIViewController) {
        stack.append(viewController)
    }
    
    func pop() {
        _ = stack.popLast()
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

}
