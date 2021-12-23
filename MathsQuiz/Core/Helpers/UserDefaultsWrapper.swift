//
//  UserDefaultsWrapper.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 18.12.2021.
//

import Foundation

struct UserDefaultsWrapper {
    
    fileprivate static let UserDefaultsStandard = UserDefaults.standard
    
    static var isSeenOnboarding: Bool {
        get {
            return UserDefaultsStandard.bool(forKey: PersistantKeys.isSeenOnboarding)
        }
        set {
            UserDefaultsStandard.set(newValue, forKey: PersistantKeys.isSeenOnboarding)
        }
    }
    
    static var uid: String? {
        get {
            return UserDefaultsStandard.string(forKey: PersistantKeys.uid)
        }
        set {
            UserDefaultsStandard.set(newValue, forKey: PersistantKeys.uid)
        }
    }
}
