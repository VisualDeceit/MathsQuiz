//
//  UserDefaultsWrapper.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 18.12.2021.
//

import Foundation

struct UserDefaultsWrapper {
    
    fileprivate static let UserDefaultsStandart = UserDefaults.standard
    
    static var isSeenOnboarding: Bool {
        get {
            return UserDefaultsStandart.bool(forKey: PersistantKeys.isSeenOnboarding)
        }
        set {
            UserDefaultsStandart.set(newValue, forKey: PersistantKeys.isSeenOnboarding)
        }
    }
    
    static var uid: String? {
        get {
            return UserDefaultsStandart.string(forKey: PersistantKeys.uid)
        }
        set {
            UserDefaultsStandart.set(newValue, forKey: PersistantKeys.uid)
        }
    }
}
