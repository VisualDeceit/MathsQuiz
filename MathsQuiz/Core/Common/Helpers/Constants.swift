//
//  Constants.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 16.12.2021.
//

import Foundation

// MARK: - Typealias
typealias PasswordPair = (password: String?, confirm: String?)
typealias CompletionBlock = () -> Void

// MARK: - PersistantKeys enum
enum PersistantKeys {
    static let isSeenOnboarding = "kIsSeenOnboarding"
    static let uid = "kUID"
}
