//
//  DesiredTasteVM.swift
//  AIropress
//
//  Created by Tomas Skypala on 18/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

class DesiredTasteVM: VariableBundleVM {

    weak var flowController: DesiredTasteSceneFC?

    @objc
    func onCalculateClicked() {
        flowController?.onParametersSet(brewParameters: brewParameters)
    }
}
