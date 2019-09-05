//
//  Double+toString.swift
//  AIropress
//
//  Created by Tomas Skypala on 31/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

extension Double {
    
     // TODO internationalize
    
    /// Converts temperature in Celsius degrees to String
    func toTempString() -> String {
        return "\(self) ºC"
    }
    
    /// Converts weight in grams to String
    func toWeightString() -> String {
        return "\(self) g"
    }
}
