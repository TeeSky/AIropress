//
//  BrewDoneVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 13/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class MockBrewDoneSceneFC: BrewDoneSceneFC {

    var calledMakeAnother: Bool?

    func onMakeAnother() {
        calledMakeAnother = true
    }
}

class BrewDoneVMTests: XCTestCase {

    var brewDoneVM: BrewDoneVM!

    override func setUp() {
        super.setUp()

        brewDoneVM = BrewDoneVM()
    }

    func testOnMakeAnother() {
        let expectedCalledMakeAnother = true
        let flowController = MockBrewDoneSceneFC()
        brewDoneVM.flowController = flowController

        brewDoneVM.onMakeAnotherClicked()

        XCTAssertEqual(expectedCalledMakeAnother, flowController.calledMakeAnother)
    }
}
