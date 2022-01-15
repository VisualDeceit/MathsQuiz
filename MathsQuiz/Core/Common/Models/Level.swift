//
//  Level.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 29.12.2021.
//

import Foundation

struct Level: Codable {
    var number: Int
    var completion: Int
    
    static var empty: Level {
        Level(number: 1, completion: 0)
    }
    
    static var blocked: Level {
        Level(number: 0, completion: -1)
    }
}
