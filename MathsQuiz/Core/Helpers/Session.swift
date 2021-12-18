//
//  Session.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 18.12.2021.
//

import Foundation

struct Session {
    static var isAuthorized: Bool {
        return UserDefaultsWrapper.uid != nil
    }
    
    static var isSeenOnboarding: Bool {
        get {
            return UserDefaultsWrapper.isSeenOnboarding
        }
        set {
            UserDefaultsWrapper.isSeenOnboarding = newValue
        }
    }
}
