//
//  Style.swift
//  AIropress
//
//  Created by Tomáš Skýpala on 11/11/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import UIKit

public enum DefaultStyle {

    public enum Color {

        public static var background: UIColor { UIColor(light: .white, dark: .black) }

        public static var text: UIColor { UIColor(light: .black, dark: .white) }
        public static var textButton: UIColor { UIColor(light: .white, dark: .white) }

        public static var buttonNormal: UIColor { UIColor(light: brownLight, dark: brownDark) }
        public static let buttonPositive = positiveGreen
        public static let buttonNegative = negativeRed

        private static let brownDark = UIColor(red: 62 / 255, green: 39 / 255, blue: 35 / 255, alpha: 1)
        private static let brownLight = UIColor(red: 141 / 255, green: 110 / 255, blue: 99 / 255, alpha: 1)

        private static let brownLightest = UIColor(red: 239 / 255, green: 235 / 255, blue: 233 / 255, alpha: 1)

        private static let positiveGreen = UIColor(red: 76 / 255, green: 175 / 255, blue: 80 / 255, alpha: 1)
        private static let negativeRed = UIColor(red: 211 / 255, green: 47 / 255, blue: 47 / 255, alpha: 1)
    }

    public enum Font {

        public static func make(ofSize size: Size, weight: UIFont.Weight = .regular) -> UIFont {
            return UIFont.systemFont(ofSize: size.rawValue, weight: weight)
        }

        public enum Size: CGFloat {
            case xlarge = 35
            case large = 25
            case normal = 20
            case small = 17
            case tiny = 12
        }
    }
}

public let Style = DefaultStyle.self
