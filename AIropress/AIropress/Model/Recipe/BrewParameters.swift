//
//  BrewParameters.swift
//  AIropress
//
//  Created by Tomas Skypala on 16/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

class BrewParameters {

    static let defaultBrewValue = 0.5

    var valueMap: [BrewVariable.Id: Double]

    convenience init(brewVariableBundles: [BrewVariableBundle], values: [BrewVariable.Id: Double?]) {
        self.init(brewVariables: brewVariableBundles.flatMap { $0.variables }, values: values)
    }

    init(brewVariables: [BrewVariable], values: [BrewVariable.Id: Double?]) {
        self.valueMap = brewVariables.reduce(into: [BrewVariable.Id: Double]()) {
            $0[$1.id] = values[$1.id] ?? BrewParameters.defaultBrewValue
        }
    }
}

extension BrewParameters: Equatable {

    static func == (lhs: BrewParameters, rhs: BrewParameters) -> Bool {
        return lhs.valueMap == rhs.valueMap
    }

}
