//
//  FirestoreManager.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 24.12.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

enum FirestoreError: Error {
    case notExist
    case emptyPath
}

extension FirestoreError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notExist:
            return NSLocalizedString("User not found", comment: "FirestoreError")
        case .emptyPath:
            return NSLocalizedString("UID is empty", comment: "FirestoreError")
        }
    }
}

class FirestoreManager {
    static let shared = FirestoreManager()
    
    private let db = Firestore.firestore()
    private init() {}

    func saveUser(uid: String, profile: UserProfile) throws {
        do {
            try db.collection("users").document(uid).setData(from: profile)
        } catch let error {
           throw error
        }
    }
    
    func readUser(uid: String?, completion: @escaping (Result<UserProfile?, Error>) -> Void) {
        guard let uid = uid, !uid.isEmpty else {
            completion(.failure(FirestoreError.emptyPath))
            return
        }
        
        let docRef = db.collection("users").document(uid)
        docRef.getDocument { (document, error) in
            guard error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            guard let document = document, document.exists else {
                completion(.failure(FirestoreError.notExist))
                return
            }
            let result = Result {
                try document.data(as: UserProfile.self)
            }
            completion(result)
        }
    }
}
