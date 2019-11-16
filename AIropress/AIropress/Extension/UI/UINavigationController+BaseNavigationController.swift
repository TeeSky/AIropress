//
//  UINavigationController+BaseNavigationController.swift
//  AIropress
//
//  Created by Tomas Skypala on 18/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController: BaseNavigationController {

    func push(viewController: UIViewController) {
        pushViewController(viewController, animated: true)
    }

    func pop(animated: Bool) {
        _ = popViewController(animated: animated)
    }
}
