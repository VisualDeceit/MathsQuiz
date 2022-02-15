//
//  MultiplicationActivityStrategy.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 15.02.2022.
//

import Foundation

final class MultiplicationActivityStrategy: ActivityStrategy {
    
    static let total = 14
    
    func generate(level: Int) -> InputData? {
        var n1, n2: Int
        switch level {
        case 1:
            n1 = 2
            n2 = Int.random(in: 2...9)
        case 2:
            n1 = Int.random(in: 3...4)
            n2 = Int.random(in: 1...5)
        case 3:
            n1 = Int.random(in: 3...4)
            n2 = Int.random(in: 6...9)
        case 4:
            n1 = 10
            n2 = Int.random(in: 2...10)
        case 5:
            n1 = 5
            n2 = Int.random(in: 2...9)
        case 6:
            n1 = Int.random(in: 6...7)
            n2 = Int.random(in: 2...5)
        case 7:
            n1 = Int.random(in: 6...7)
            n2 = Int.random(in: 6...9)
        case 8:
            n1 = Int.random(in: 8...9)
            n2 = Int.random(in: 2...5)
        case 9:
            n1 = Int.random(in: 8...9)
            n2 = Int.random(in: 6...9)
        case 10:
            n1 = Int.random(in: 6...9)
            n2 = Int.random(in: 2...4)
        case 11:
            n1 = Int.random(in: 6...9)
            n2 = Int.random(in: 6...9)
        case 12:
            n1 = 11
            n2 = Int.random(in: 2...12)
        case 13:
            n1 = 12
            n2 = Int.random(in: 2...12)
        case 14:
            n1 = Int.random(in: 13...19)
            n2 = Int.random(in: 2...9)
        default:
            return nil
        }
        return .init(firstNumber: n1, secondNumber: n2)
    }
}
