//
//  BrewingPlan.swift
//  AIropress
//
//  Created by Tomas Skypala on 10/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

struct BrewPhase: Equatable {
    let duration: Double
    let label: String
}

protocol BrewingPlan {
    var orderedPhases: [BrewPhase] { get }
}
