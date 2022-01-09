//
//  UserProfile.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 24.12.2021.
//

import Foundation

enum Sex: String, Codable, CaseIterable {
    case male = "Мужской"
    case female = "Женский"
}

struct UserProfile: Codable {
    let email: String?
    let phone: String?
    let city: String?
    let lastName: String?
    let firstName: String?
    let sex: Sex?
    let birthday: Date?
}
