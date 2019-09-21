//
//  Double+toString.swift
//  AIropress
//
//  Created by Tomas Skypala on 31/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

extension Double {

    func asStopwatchString() -> String {
        let minutes = Int(self.truncatingRemainder(dividingBy: 3600) / 60)
        let seconds = Int(self.truncatingRemainder(dividingBy: 60))

        return String(format: "%02i:%02i", minutes, seconds)
    }

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
