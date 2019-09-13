//
//  AllDoneVMTests.swift
//  AIropressTests
//
//  Created by Tomas Skypala on 13/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import XCTest

class AllDoneVM: BaseViewModel {
    
    weak var flowController: AllDoneSceneFC?
    
    func onMakeAnotherClicked() {
        flowController?.onMakeAnother()
    }
}

class MockAllDoneSceneFC: AllDoneSceneFC {
    
    var calledMakeAnother: Bool?
    
    func onMakeAnother() {
        calledMakeAnother = true
    }
    
}

class AllDoneVMTests: XCTestCase {

    var allDoneVM: AllDoneVM!
    
    override func setUp() {
        super.setUp()
        
        allDoneVM = AllDoneVM()
    }
    
    func testOnMakeAnother() {
        let expectedCalledMakeAnother = true
        let flowController = MockAllDoneSceneFC()
        allDoneVM.flowController = flowController
        
        allDoneVM.onMakeAnotherClicked()
        
        XCTAssertEqual(expectedCalledMakeAnother, flowController.calledMakeAnother)
    }

}
