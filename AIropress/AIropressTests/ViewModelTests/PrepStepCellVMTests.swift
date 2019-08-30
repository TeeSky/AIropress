//
//  PrepStepCellVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 28/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

enum AeropressBrewOrientation: String {
    case normal = "Screw on the filter holder and place the Aeropress on the cup."
    case inverted = "Insert plunger, turn the Aeropress upside-down."
}

enum PrepStep {
    case preheatWater(String)
    case rinseFilter
    case rinseAeropress
    case orientate(AeropressBrewOrientation)
    case placeOnScale
    case weighXCoffee(String)
    case prepareKettle
    
    func text() -> String {
        let text: String
        switch self {
        case .preheatWater(let tempString):
            text = "Preheat filtered water to \(tempString)."
        case .rinseFilter:
            text = "Rinse brewing filter with hot water inside coffee cup."
        case .rinseAeropress:
            text = "Preheat the Aeropress tube and plunger too by rinsing with hot water."
        case .orientate(let orientation):
            text = orientation.rawValue
        case .placeOnScale:
            text = "Place the Aeropress on scale, tare."
        case .weighXCoffee(let weightString):
            text = "Put exactly \(weightString) of coffee into the Aeropress."
        case .prepareKettle:
            text = "Tare the scale again and prepare your brewing kettle with the hot water."
        }
        return text
    }
}

class PrepStepCellVM {
    
    static let cellIdentifier: String = {
        return "ConstantCellVM"
    }()

    static let cellHeight: CGFloat = {
        return 50
    }()

    let cellText: String
 
    init(cellIndex: Int, prepStep: PrepStep) {
        self.cellText = "\(cellIndex + 1). \(prepStep.text())"
    }
}

extension PrepStepCellVM: BaseTableCellVM {
    
    var identifier: String {
        return PrepStepCellVM.cellIdentifier
    }
    
    var cellHeight: CGFloat {
        return PrepStepCellVM.cellHeight
    }
    
}

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
