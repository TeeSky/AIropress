//
//  BrewVariable.swift
//  AIropress
//
//  Created by Tomas Skypala on 18/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

struct BrewVariableBundle: Equatable {
    let label: String
    let variables: [BrewVariable]
}

struct BrewVariable: Equatable {
    typealias Id = Int
    
    let id: Id
    let stepCount: Int
    let labelSet: VariableLabelSet
}

extension BrewVariable: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct VariableLabelSet: Equatable {
    let mainLabel: String
    let minLabel: String
    let maxLabel: String
}
