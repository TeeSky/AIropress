//
//  FStore.swift
//  AIropress
//
//  Created by Tomas Skypala on 17/11/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FStore {
    
    static func configure() {
        let settings = Firestore.firestore().settings
        
        settings.isPersistenceEnabled = true
        settings.cacheSizeBytes = FirestoreCacheSizeUnlimited
        
        Firestore.firestore().settings = settings
    }
    
    // MARK: - Collections
}
