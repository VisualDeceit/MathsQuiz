//
//  AdditionInputStrategy.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 29.12.2021.
//

import Foundation

final class AdditionActivityStrategy: ActivityStrategy {
    
    static let total = 5
    
    func generate(level: Int) -> InputData? {
        var n1, n2: Int
        switch level {
        case 1:
            // Sum is between 6 and 9
            let sum = Int.random(in: 6...9)
            n1 = Int.random(in: 1..<sum)
            n2 = sum - n1
        case 2:
            // Sum is between 11 and 19, no carry
            let sum = Int.random(in: 11...19)
            n1 = Int.random(in: 10..<sum)
            n2 = sum - n1
        case 3:
            // Sum is between 10 and 12, always carry
            let sum = Int.random(in: 10...12)
            n1 = Int.random(in: (sum - 9)..<9)
            n2 = sum - n1
        case 4:
            // Sum is between 13 and 18, always carry
            let sum = Int.random(in: 13...18)
            n1 = Int.random(in: (sum - 9)...9)
            n2 = sum - n1
        case 5:
            // Sum is between 20 and 28, one single digit number
            let sum = Int.random(in: 20...28)
            n1 = Int.random(in: (sum - 19)...9)
            n2 = sum - n1
        default:
            return nil
        }
        return .init(firstNumber: n1, secondNumber: n2)
    }
}
