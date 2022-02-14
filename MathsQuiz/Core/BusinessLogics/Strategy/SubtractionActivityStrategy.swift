//
//  SubtractionActivityStrategy.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 10.02.2022.
//

import Foundation

final class SubtractionActivityStrategy: ActivityStrategy {
    
    static let total = 10
    
    func generate(level: Int) -> InputData? {
        var n1, n2: Int
        switch level {
        case 1:
            n1 = Int.random(in: 3...9)
            n2 = Int.random(in: 1...3)
        case 2:
            n1 = Int.random(in: 4...9)
            n2 = Int.random(in: 1...3)
        case 3:
            n1 = Int.random(in: 7...10)
            n2 = Int.random(in: 4...6)
        case 4:
            n1 = Int.random(in: 14...20)
            n2 = Int.random(in: 2...4)
        case 5:
            n1 = Int.random(in: 16...19)
            n2 = Int.random(in: 5...min(getDigit(from: n1, at: 1), 7))
        case 6:
            n1 = Int.random(in: 26...29)
            n2 = Int.random(in: 4...min(getDigit(from: n1, at: 1), 7))
        case 7:
            n1 = Int.random(in: 15...19)
            n2 = Int.random(in: 14...min(n1, 17))
        case 8:
            n1 = Int.random(in: 2...9) * 10 + Int.random(in: 2...9)
            n2 = Int.random(in: 2...min(getDigit(from: n1, at: 1), 9))
        case 9:
            n1 = Int.random(in: 2...9) * 10 + Int.random(in: 2...9)
            n2 = Int.random(in: 2...min(getDigit(from: n1, at: 2), 9)) * 10 +
                 Int.random(in: 2...min(getDigit(from: n1, at: 1), 9))
        case 10:
            n1 = Int.random(in: 2...9) * 100 + Int.random(in: 2...9) * 10 + Int.random(in: 2...9)
            n2 = Int.random(in: 2...min(getDigit(from: n1, at: 3), 9)) * 100 +
                 Int.random(in: 2...min(getDigit(from: n1, at: 2), 9)) * 10 +
                 Int.random(in: 2...min(getDigit(from: n1, at: 1), 9))
        default:
            return nil
        }
        return .init(firstNumber: n1, secondNumber: n2)
    }
}
