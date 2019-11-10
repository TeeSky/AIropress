//
//  BrewVariable.swift
//  AIropress
//
//  Created by Tomas Skypala on 18/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

struct BrewVariableBundle: Equatable, Codable {
    let label: String
    let variables: [BrewVariable]
}

struct BrewVariable: Equatable, Codable {
    typealias Id = Int

    static let confidenceVariableStepCount = 5
    static let confidenceVariableLabelSet = VariableLabelSet(mainLabel: "Confidence",
                                                             minLabel: "Unconfident",
                                                             maxLabel: "Confident")

    let id: Id
    let stepCount: Int
    let labelSet: VariableLabelSet

    static func createConfidenceVariable(id: BrewVariable.Id) -> BrewVariable {
        return BrewVariable(id: id, stepCount: confidenceVariableStepCount, labelSet: confidenceVariableLabelSet)
    }
}

extension BrewVariable: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct VariableLabelSet: Equatable, Codable {
    let mainLabel: String
    let minLabel: String
    let maxLabel: String
}
