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
    func saveUserProfile(uid: String?, profile: UserProfile) throws
    func loadUserProfile(uid: String?, completion: @escaping (Result<UserProfile, Error>) -> Void)
    func isUserProfileExist(uid: String?, completion: @escaping ((Bool) -> Void))
    func loadActivities(uid: String?, completion: @escaping (Result<[Activity], Error>) -> Void)
    func loadLevels(uid: String?,
                    activityType: ActivityType,
                    completion: @escaping (Result<[Level], Error>) -> Void)
    func saveLevel(uid: String?,
                   level: Level,
                   activityType: ActivityType,
                   completion: ((Error) -> Void)?)
    func loadStatistics(uid: String?,
                        activityType: ActivityType,
                        completion: @escaping (Result<ActivityStatistics, Error>) -> Void)
}

class FirestoreManager: StorageManager {
    
    private let db = Firestore.firestore()

    func saveUserProfile(uid: String?, profile: UserProfile) throws {
        guard let uid = uid else {
            throw FirestoreError.emptyPath
        }
        try db.collection("users").document(uid).setData(from: profile)
    }
    
    func loadUserProfile(uid: String?, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        guard let uid = uid else {
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
        guard let uid = uid else {
            completion(false)
            return
        }
        
        let docRef = db.collection("users").document(uid)
        docRef.getDocument { (document, _) in
            guard let document = document, document.exists else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func loadActivities(uid: String?, completion: @escaping (Result<[Activity], Error>) -> Void) {
        guard let uid = uid else {
            completion(.failure(FirestoreError.emptyPath))
            return
        }
        
        let collectionRef = db.collection("users").document(uid).collection("activity_list")
        collectionRef.getDocuments {(activitySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let activitySnapshot = activitySnapshot else {
                    completion(.failure(FirestoreError.activitiesIsEmpty))
                    return
                }
                
                var activityList = [Activity]()
                
                for document in activitySnapshot.documents {
                    if let activity = try? document.data(as: Activity.self),
                       ActivityType.allCases.contains(activity.type) {
                        activityList.append(activity)
                    } else {
                        document.reference.delete()
                    }
                }
                
                ActivityType.allCases.enumerated().forEach { index, activityType in
                    guard !activityList.lazy.map(\.type).contains(activityType) else { return }
                    let activity = Activity(index: index, type: activityType)
                    activityList.append(activity)
                    do {
                        try collectionRef.document().setData(from: activity)
                    } catch {
                        completion(.failure(error))
                    }
                }
                completion(.success(activityList.sorted { $0.index < $1.index }))
            }
        }
    }
    
    func loadLevels(uid: String?, activityType: ActivityType, completion: @escaping (Result<[Level], Error>) -> Void) {
        guard let uid = uid else {
            completion(.failure(FirestoreError.emptyPath))
            return
        }
        
        let collectionRef = db.collection("users").document(uid).collection("activity_list")
        collectionRef.whereField("type", isEqualTo: activityType.rawValue).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let documentRef = querySnapshot?.documents.first?.reference
                else {
                    completion(.failure(FirestoreError.levelIsEmpty))
                    return
                }
                
                documentRef.collection("levels_list").getDocuments { (levelsSnapshot, error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        guard let levelsSnapshot = levelsSnapshot else {
                            completion(.failure(FirestoreError.activitiesIsEmpty))
                            return
                        }
                        do {
                            var levels = try levelsSnapshot.documents.compactMap {
                                try $0.data(as: Level.self)
                            }
                            
                            // init levels at first time
                            if levels.isEmpty {
                                let empty = Level(number: 1, attempts: 0, score: 0, time: 0)
                                levels.append(empty)
                                try documentRef.collection("levels_list").document().setData(from: empty)
                            }
                            
                            completion(.success(levels.sorted { $0.number < $1.number }))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                }
            }
        }
    }
    
    func saveLevel(uid: String?, level: Level, activityType: ActivityType, completion: ((Error) -> Void)? = nil) {
        guard let uid = uid else {
            completion?(FirestoreError.emptyPath)
            return
        }
        
        db.collection("users").document(uid).collection("activity_list")
            .whereField("type", isEqualTo: activityType.rawValue)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion?(error)
                } else {
                    let levelListRef = querySnapshot?.documents.first?
                        .reference.collection("levels_list")
                    
                    // unlock new level
                    levelListRef?.getDocuments(completion: { (querySnapshot, error) in
                        if let error = error {
                            completion?(error)
                        } else {
                            if let documents = querySnapshot?.documents {
                                if level.attempts > 0,
                                   documents.count == level.number,
                                   documents.count < activityType.totalLevels {
                                    let empty = Level(number: level.number + 1, attempts: 0, score: 0, time: 0)
                                    do {
                                        try levelListRef?.document().setData(from: empty)
                                    } catch {
                                        completion?(error)
                                    }
                                }
                            }
                        }
                    })
                    
                    // update level
                    levelListRef?.whereField("number", isEqualTo: level.number)
                        .getDocuments(completion: { (querySnapshot, error) in
                            if let error = error {
                                completion?(error)
                            } else {
                                let document = querySnapshot?.documents.first
                                
                                guard let currentLevel = try? document?.data(as: Level.self) else {
                                    return
                                }
                                
                                if level.attempts > currentLevel.attempts {
                                    document?.reference.updateData(["attempts": level.attempts])
                                }
                                if level.score > currentLevel.score {
                                    document?.reference.updateData(["score": level.score])
                                }
                                if level.time < currentLevel.time || currentLevel.time == 0 {
                                    document?.reference.updateData(["time": level.time])
                                }
                            }
                        })
                }
            }
    }
    
    func loadStatistics(uid: String?, activityType: ActivityType, completion: @escaping (Result<ActivityStatistics, Error>) -> Void) {
        guard let uid = uid else {
            completion(.failure(FirestoreError.emptyPath))
            return
        }
        
        db.collection("users").document(uid).collection("activity_list")
            .whereField("type", isEqualTo: activityType.rawValue)
            .getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let documentRef = querySnapshot?.documents.first?.reference
                else {
                    completion(.failure(FirestoreError.levelIsEmpty))
                    return
                }
                
                documentRef.collection("levels_list").getDocuments { (levelsSnapshot, error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        guard let levelsSnapshot = levelsSnapshot else {
                            completion(.failure(FirestoreError.activitiesIsEmpty))
                            return
                        }
                        do {
                            let levels = try levelsSnapshot.documents.compactMap {
                                try $0.data(as: Level.self)
                            }
                            
                            let score = levels.map(\.score).reduce(0, +)
                            let percent = levels.filter { $0.attempts > 0 }.count
                            let time = levels.map(\.time).reduce(0, +)

                            let statistics = ActivityStatistics(totalScore: score,
                                                                completion: percent,
                                                                time: time)
                            completion(.success(statistics))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                }
            }
        }
    }
}
