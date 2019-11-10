//
//  File.swift
//  AIropress
//
//  Created by Tomas Skypala on 18/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

struct AppOptions {

    static let brewVariableBundles = AppBrewVariableBundles.makeFromAssets().bundles
    static let color = AppColor()
    static let fontSize = AppFontSize()

    static let nonAvailableText = "n/a"

    private init() {}
}

struct AppBrewVariableBundles: Codable {

    let bundles: [BrewVariableBundle]

    private init(bundles: [BrewVariableBundle]) {
        self.bundles = bundles
    }

    static func makeFromAssets(bundle: Bundle = Bundle.main) -> AppBrewVariableBundles {
        let decoder = JSONDecoder()
        let asset = NSDataAsset(name: "BrewVariableBundles", bundle: bundle)

        guard
            let variableBundles = try? decoder.decode(
                AppBrewVariableBundles.self,
                from: asset!.data
                ) as AppBrewVariableBundles
            else {
                fatalError("Could not decode AppBrewVariableBundles. Make sure there is " +
                    "a proper \"BrewVariableBundles\" data asset available.")
        }
        return variableBundles
    }
}

struct AppColor {

    let button =  UIColor(red: 62/255, green: 39/255, blue: 35/255, alpha: 1)
    let buttonPositive =  UIColor(red: 76/255, green: 175/255, blue: 80/255, alpha: 1)
    let buttonNegative =  UIColor(red: 211/255, green: 47/255, blue: 47/255, alpha: 1)

    fileprivate init() {
    }
}

struct AppFontSize {

    let xlarge: CGFloat = 35
    let large: CGFloat = 25
    let normal: CGFloat = 20
    let small: CGFloat = 17
    let tiny: CGFloat = 12

    fileprivate init() {
    }
}
