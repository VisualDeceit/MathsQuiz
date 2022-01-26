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
    case activitiesIsEmpty
    case levelIsEmpty
}

extension FirestoreError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notExist:
            return NSLocalizedString("User not found", comment: "FirestoreError")
        case .emptyPath:
            return NSLocalizedString("UID is empty", comment: "FirestoreError")
        case .activitiesIsEmpty:
            return NSLocalizedString("Activity is empty", comment: "FirestoreError")
        case .levelIsEmpty:
            return NSLocalizedString("Levels is empty", comment: "FirestoreError")
        }
    }
}

protocol StorageManager {
    func saveUserProfile(profile: UserProfile) throws
    func loadUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void)
    func isUserProfileExist(uid: String?, completion: @escaping ((Bool) -> Void))
    func loadActivities(_ completion: @escaping (Result<[Activity], Error>) -> Void)
    func loadLevels(for activity: ActivityType, completion: @escaping (Result<[Level], Error>) -> Void)
}

class FirestoreManager: StorageManager {
    
    private let db = Firestore.firestore()

    func saveUserProfile(profile: UserProfile) throws {
        guard let uid = Session.uid, !uid.isEmpty else {
            throw FirestoreError.emptyPath
        }
        try db.collection("users").document(uid).setData(from: profile)
    }
    
    func loadUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        guard let uid = Session.uid, !uid.isEmpty else {
            completion(.failure(FirestoreError.emptyPath))
            return
        }
        
        let docRef = db.collection("users").document(uid)
        docRef.getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let document = document, document.exists else {
                completion(.failure(FirestoreError.notExist))
                return
            }
            guard let data = try? document.data(as: UserProfile.self) else {
                completion(.failure(FirestoreError.notExist))
                return
            }
            let result = Result { data }
            completion(result)
        }
    }
    
    func isUserProfileExist(uid: String?, completion: @escaping ((Bool) -> Void)) {
        let docRef = db.collection("users").document(uid ?? "uid")
        docRef.getDocument { (document, _) in
            guard let document = document, document.exists else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func loadActivities(_ completion: @escaping (Result<[Activity], Error>) -> Void) {
        guard let uid = Session.uid, !uid.isEmpty else {
            completion(.failure(FirestoreError.emptyPath))
            return
        }
        
        let collectionRef = db.collection("users").document(uid).collection("activity")
        collectionRef.getDocuments {(activitySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let activitySnapshot = activitySnapshot else {
                    completion(.failure(FirestoreError.activitiesIsEmpty))
                    return
                }
                
                var activities = [Activity]()
                for document in activitySnapshot.documents {
                    if let item = try? document.data(as: Activity.self) {
                        activities.append(item)
                    }
                }
                
                if activities.isEmpty {
                    activities = Stub.activities
                    activities.forEach {
                        do {
                            _ = try collectionRef.addDocument(from: $0)
                        } catch {
                            print(error)
                        }
                    }
                }
                
                completion(.success(activities.sorted { $0.index < $1.index }))
            }
        }
    }
    
    func loadLevels(for activity: ActivityType, completion: @escaping (Result<[Level], Error>) -> Void) {
        guard let uid = Session.uid, !uid.isEmpty else {
            completion(.failure(FirestoreError.emptyPath))
            return
        }
        
        let collectionRef = db.collection("users").document(uid).collection("activity")
        collectionRef.whereField("type", isEqualTo: activity.rawValue).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let document = querySnapshot?.documents.first,
                      let activity = try? document.data(as: Activity.self) else {
                    completion(.failure(FirestoreError.levelIsEmpty))
                    return
                }
                completion(.success(activity.levels))
            }
        }
    }
}
