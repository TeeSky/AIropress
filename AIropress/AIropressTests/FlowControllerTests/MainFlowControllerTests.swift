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

class MainFlowController {
    
    let navigationController: BaseNavigationController
    
    init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
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
    
    func testInitWithNavigationController() {
        let navigationController = MockNavigationController()
        
        let mainFlowController = MainFlowController(navigationController: navigationController)
        
        XCTAssertNotNil(mainFlowController.navigationController)
    }

}
