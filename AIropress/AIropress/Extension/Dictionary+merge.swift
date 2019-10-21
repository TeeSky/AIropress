//
//  Dictionary+merge.swift
//  AIropress
//
//  Created by Tomas Skypala on 19/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation

extension Dictionary {

    mutating func merge(dict: [Key: Value]) {
        for (key, value) in dict {
            updateValue(value, forKey: key)
        }
    }
}
