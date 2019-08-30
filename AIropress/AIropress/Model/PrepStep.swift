//
//  PrepStep.swift
//  AIropress
//
//  Created by Tomas Skypala on 30/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

enum AeropressBrewOrientation: String {
    case normal = "Screw on the filter holder and place the Aeropress on the cup."
    case inverted = "Insert plunger, turn the Aeropress upside-down."
}

enum PrepStep {
    case preheatWater(String)
    case rinseFilter
    case rinseAeropress
    case orientate(AeropressBrewOrientation)
    case placeOnScale
    case weighXCoffee(String)
    case prepareKettle
    
    func text() -> String {
        let text: String
        switch self {
        case .preheatWater(let tempString):
            text = "Preheat filtered water to \(tempString)."
        case .rinseFilter:
            text = "Rinse brewing filter with hot water inside coffee cup."
        case .rinseAeropress:
            text = "Preheat the Aeropress tube and plunger too by rinsing with hot water."
        case .orientate(let orientation):
            text = orientation.rawValue
        case .placeOnScale:
            text = "Place the Aeropress on scale, tare."
        case .weighXCoffee(let weightString):
            text = "Put exactly \(weightString) of coffee into the Aeropress."
        case .prepareKettle:
            text = "Tare the scale again and prepare your brewing kettle with the hot water."
        }
        return text
    }
}
