//
//  BaseViewControllerTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 19/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

private class MockSceneView: BaseSceneView {

    var didCallRender: Bool = false

    override func render() {
        didCallRender = true
    }
}

class BaseViewControllerTests: XCTestCase {

    private var viewController: BaseViewController<MockSceneView>!

    override func setUp() {
        super.setUp()

        viewController = BaseViewController()
    }

    func testInit() {
        XCTAssertNotNil(viewController.sceneView)
    }

    func testRenderOnViewDidLoad() {
        viewController.viewDidLoad()

        XCTAssertTrue(viewController.sceneView.didCallRender)
    }
}
