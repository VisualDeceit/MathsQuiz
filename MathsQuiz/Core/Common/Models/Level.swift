//
//  Level.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 29.12.2021.
//

import Foundation

struct Level: Codable {
    var number: Int
    var attempts: Int
    var score: Int
    var time: Int
}
