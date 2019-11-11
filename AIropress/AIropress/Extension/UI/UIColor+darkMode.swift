//
//  UIColor+darkMode.swift
//  AIropress
//
//  Created by Tomáš Skýpala on 11/11/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(light: UIColor, dark: UIColor) {
        let color: UIColor

        if #available(iOS 13, *) {
            color = UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                    if UITraitCollection.userInterfaceStyle == .dark {
                        /// Return the color for Dark Mode
                        return dark
                    } else {
                        /// Return the color for Light Mode
                        return light
                    }
                }
        } else {
            /// Return a fallback color for iOS 12 and lower.
            color = light
        }

        self.init(
            red: color.red,
            green: color.green,
            blue: color.blue,
            alpha: color.alpha
        )
    }

    var red: CGFloat {
        return component(index: 0)
    }

    var green: CGFloat {
        return component(index: 1)
    }

    var blue: CGFloat {
        return component(index: 2)
    }

    var alpha: CGFloat {
        return component(index: 3, alternativeIndex: 1)
    }

    private func component(index: Int, alternativeIndex: Int = 0) -> CGFloat {

        let colorComponents = cgColor.components
        guard
            let rgbaComponents = colorComponents,
            rgbaComponents.count == 4
        else {
            // With white there should be 2 components (white, alpha)
            return colorComponents?[safe: alternativeIndex] ?? 1.0
        }

        return rgbaComponents[index]
    }
}
