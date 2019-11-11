//
//  BaseViewController.swift
//  AIropress
//
//  Created by Tomas Skypala on 19/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

/**
 **BaseViewController** extends standard **UIViewController** with conveniently initiated
 view provided as typed **BaseSceneView** subclass.
 */
class BaseViewController<SV: BaseSceneView>: UIViewController {

    /**
     ViewController's base UIView.
     */
    var sceneView: SV {
        guard let view = view as? SV else {
            fatalError("Unexpected BaseViewController view type.")
        }
        return view
    }

    override func loadView() {
        view = SV()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.render()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        sceneView.setColors()
    }
}
