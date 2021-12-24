//
//  FirestoreManager.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 24.12.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreManager {
    static let shared = FirestoreManager()
    
    private let storage = Firestore.firestore()
    private init() {}

    func saveUser(uid: String, profile: UserProfile) throws {
        do {
            try storage.collection("users").document(uid).setData(from: profile)
        } catch let error {
           throw error
        }
    }
}
