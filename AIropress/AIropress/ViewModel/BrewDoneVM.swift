//
//  BrewDoneVM.swift
//  AIropress
//
//  Created by Tomas Skypala on 13/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

class BrewDoneVM: VariableBundleVM {

    weak var flowController: BrewDoneSceneFC?

    @objc
    func onMakeAnotherTapped() {
        flowController?.onMakeAnother()
    }
}
