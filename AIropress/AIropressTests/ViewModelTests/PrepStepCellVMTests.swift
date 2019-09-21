//
//  PrepStepCellVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 28/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class PrepStepCellVMTests: XCTestCase {

    var cellIndex: Int!
    var prepStep: PrepStep!

    var prepStepCellVM: PrepStepCellVM!

    override func setUp() {
        super.setUp()

        cellIndex = 2
        prepStep = PrepStep.orientate(.inverted)
        prepStepCellVM = PrepStepCellVM(cellIndex: cellIndex, prepStep: prepStep)
    }

    func testInit() {
        let expectedCellText = "\(cellIndex + 1). \(prepStep.text())"

        XCTAssertEqual(expectedCellText, prepStepCellVM.cellText)
    }

    func testCellIdentifier() {
        let expectedIdentifier = PrepStepCellVM.cellIdentifier

        XCTAssertEqual(expectedIdentifier, prepStepCellVM.identifier)
    }

    func testCellHeight() {
        let expectedHeight = PrepStepCellVM.cellHeight

        XCTAssertEqual(expectedHeight, prepStepCellVM.cellHeight)
    }
}
