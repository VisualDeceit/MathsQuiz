//
//  Session.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 18.12.2021.
//

import Foundation

struct Session {
    @UserDefaultsStorage(key: PersistantKeys.isSeenOnboarding, defaultValue: false)
    static var isSeenOnboarding: Bool
    
    @UserDefaultsStorage(key: PersistantKeys.uid, defaultValue: nil)
    static var uid: String?
    
    static var isAuthorized: Bool {
        return uid != nil
    }
}
