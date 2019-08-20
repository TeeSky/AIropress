//
//  BrewVariableBundleCellTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 19/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest
import UIKit

class BrewVariableBundleCell: UITableViewCell {
    
    var viewModel: BrewVariableBundleCellVM! {
        didSet {
            label.text = viewModel.variableBundle.label
        }
    }
    
    lazy var label: UILabel = {
        return UILabel()
    }()
    var sliders: [DiscreteSlider]!
}

class BrewVariableBundleCellTests: XCTestCase {

    var viewModel: BrewVariableBundleCellVM!
    var brewVariableBundleCell: BrewVariableBundleCell!
    
    override func setUp() {
        super.setUp()
        
        viewModel = BrewVariableBundleCellVM(variableBundle: MockBrewVars.tasteBundle)
        brewVariableBundleCell = BrewVariableBundleCell()
        brewVariableBundleCell.viewModel = viewModel
    }
    
    func testLabelText() {
        let expectedLabel = viewModel.variableBundle.label
        
        XCTAssertEqual(expectedLabel, brewVariableBundleCell.label.text)
    }
    
    // TODO implement the rest
}
