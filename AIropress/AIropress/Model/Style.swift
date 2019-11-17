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

        public static var tint: UIColor { UIColor(light: brownLight, dark: brownDark) }

        public static var background: UIColor { UIColor(light: .white, dark: .black) }

        public static var text: UIColor { UIColor(light: .black, dark: .white) }
        public static var textButton: UIColor { UIColor(light: .white, dark: .white) }

        public static var buttonNormal: UIColor { tint }
        public static let buttonPositive = positiveGreen
        public static var buttonNegative: UIColor { UIColor(light: negativeLightGrey, dark: negativeDarkGrey) }

        private static let brownDark = UIColor(red: 62 / 255, green: 39 / 255, blue: 35 / 255, alpha: 1)
        private static let brownLight = UIColor(red: 93 / 255, green: 64 / 255, blue: 55 / 255, alpha: 1)

        private static let brownLightest = UIColor(red: 239 / 255, green: 235 / 255, blue: 233 / 255, alpha: 1)

        private static let positiveGreen = UIColor(red: 76 / 255, green: 175 / 255, blue: 80 / 255, alpha: 1)

        private static let negativeLightGrey = UIColor(white: 189 / 255, alpha: 1)
        private static let negativeDarkGrey = UIColor(white: 97 / 255, alpha: 1)

        private static let negativeRed = UIColor(red: 183 / 255, green: 28 / 255, blue: 28 / 255, alpha: 1)
    }

    public enum Font {

        public static func make(ofSize size: Size = .normal, weight: UIFont.Weight = .regular) -> UIFont {
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
