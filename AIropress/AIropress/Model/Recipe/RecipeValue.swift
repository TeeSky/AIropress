//
//  RecipeValue.swift
//  AIropress
//
//  Created by Tomas Skypala on 19/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

enum RecipeValue: Int {
    case aeropressOrientation = 100
    case temperature = 101
    case grindSize = 102
    case coffeeAmount = 103
    case waterAmount = 104
    
    case bloomDuration = 200
    case brewDuration = 201
    case totalBrewDuration = 202
    
    case hiddenValuePlaceholder = 299
    
    static let stringifiers: [RecipeValue: ValueStringifier] =
        [.aeropressOrientation: AeropressOrientationStringifier(),
         .grindSize: ComandanteGrindSizeStringifier(),
         .coffeeAmount: SimpleUnitStringifier(label: "Coffee", unit: "g"),
         .waterAmount: SimpleUnitStringifier(label: "Water", unit: "ml"),
         .temperature: SimpleUnitStringifier(label: "Temperature", unit: "C"),
         .totalBrewDuration: TimeStringifier(label: "Total brewing time"),
         .bloomDuration: TimeStringifier(label: "Bloom time")
    ]
    
    func stringifier() -> ValueStringifier? {
        return RecipeValue.stringifiers[self]
    }
    
    static func createRecipeValueMap(from valueMap: [Int: Double]) -> [RecipeValue: Double] {
        var recipeValueMap: [RecipeValue: Double] = [:]
        
        for (id, value) in valueMap {
            if let recipeValueId = RecipeValue.init(rawValue: id) {
                recipeValueMap[recipeValueId] = value
            }
        }
        return recipeValueMap
    }
}

protocol ValueStringifier {
    func labelText() -> String
    func toString(value: Double) -> String
}

class SimpleUnitStringifier: ValueStringifier {
    
    let label: String
    let unit: String
    
    init(label: String, unit: String) {
        self.label = label
        self.unit = unit
    }
    
    func labelText() -> String {
        return label
    }
    
    func toString(value: Double) -> String {
        return "\(value) \(unit)"
    }
    
}

class TimeStringifier: SimpleUnitStringifier {
    
    init(label: String) {
        super.init(label: label, unit: "")
    }
    
    override func toString(value: Double) -> String {
        return "\(value.asStopwatchString())"
    }
    
}

class AeropressOrientationStringifier: ValueStringifier {
    
    init() {
    }
    
    func labelText() -> String {
        return "Aerop. orientation"
    }
    
    func toString(value: Double) -> String {
        let defaultString = AppOptions.nonAvailableText
        
        return AeropressBrewOrientation.fromDouble(value: value)?.valueText() ?? defaultString
    }
}

class ComandanteGrindSizeStringifier: ValueStringifier {
    
    init() {
    }
    
    func labelText() -> String {
        return "Grind size"
    }
    
    func toString(value: Double) -> String {
        return valueToLabel(value: value)
    }
    
    private func valueToLabel(value: Double) -> String {
        let defaultString = AppOptions.nonAvailableText
        
        switch value {
        case 1...10:
            return "very fine"
        case 10...15:
            return "fine"
        case 15...20:
            return "normal"
        case 20...27:
            return "coarse"
        case 27...31:
            return "very coarse"
        default:
            return defaultString
        }
    }
}
