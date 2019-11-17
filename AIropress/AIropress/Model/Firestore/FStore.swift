//
//  FStore.swift
//  AIropress
//
//  Created by Tomas Skypala on 17/11/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol FSObject: Codable {

    static var collectionId: String { get }
}

class FStore {

    static func configure() {
        let settings = Firestore.firestore().settings

        settings.isPersistenceEnabled = true
        settings.cacheSizeBytes = FirestoreCacheSizeUnlimited
        Firestore.firestore().settings = settings
    }

    // MARK: - Collections

    static func getAll<O: FSObject>(_: O.Type, completion: @escaping ([O]) -> Void) {
        Firestore.firestore().collection(O.collectionId).getDocuments { querySnapshot, _ in
            guard let documents = querySnapshot?.documents else { return }

            var objects = [O]()
            for document in documents {
                let decoder = JSONDecoder()
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: document.data())
                    let recipe = try decoder.decode(O.self, from: jsonData)
                    objects.append(recipe)
                } catch let error {
                    print("Failed to decode Firestore object of \(O.self) type: \(error.localizedDescription)")
                }
            }
            completion(objects)
        }
    }
}
