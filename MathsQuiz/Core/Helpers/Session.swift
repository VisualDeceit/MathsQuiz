//
//  Session.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 18.12.2021.
//

import Foundation

typealias Credentials = (username: String, password: String)

struct Session {
    static var isAuthorized: Bool {
        return UserDefaultsWrapper.token != nil
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
