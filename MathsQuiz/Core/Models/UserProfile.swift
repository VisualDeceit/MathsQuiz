//
//  UserProfile.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 24.12.2021.
//

import Foundation

enum SexType: String, Codable {
    case male, female
}

struct UserProfile: Codable {
    let email: String
    let phone: String?
    let city: String?
    let lastName: String?
    let firstName: String?
    let sex: SexType?
    let birthday: Date?
}
