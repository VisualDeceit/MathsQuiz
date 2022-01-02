//
//  UserDefaultsStorage.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 23.12.2021.
//

import Foundation

private protocol OptionalProtocol {
    var isNil: Bool { get }
}

extension Optional: OptionalProtocol {
    var isNil: Bool {
        return self == nil
    }
}

@propertyWrapper
struct UserDefaultsStorage<T> {
    private let key: String
    private let defaultValue: T
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            if let value = newValue as? OptionalProtocol, value.isNil {
                UserDefaults.standard.removeObject(forKey: key)
            } else {
                UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
