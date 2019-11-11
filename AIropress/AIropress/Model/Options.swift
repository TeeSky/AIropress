//
//  Options.swift
//  AIropress
//
//  Created by Tomas Skypala on 18/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import UIKit

public struct AppBrewVariableBundles: Codable {

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

public enum DefaultOptions {

    public static let brewVariableBundles = AppBrewVariableBundles.makeFromAssets().bundles
    public static let nonAvailableText = "n/a"

}

public let Options = DefaultOptions.self
