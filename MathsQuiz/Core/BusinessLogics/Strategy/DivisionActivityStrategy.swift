//
//  DivisionActivityStrategy.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 17.02.2022.
//

import Foundation

final class DivisionActivityStrategy: ActivityStrategy {
    
    static let total = 15
    
    func generate(level: Int) -> InputData? {
        var n1, n2: Int
        switch level {
        case 1:
            n1 = 2 * Int.random(in: 1...4) * 10 + 2 * Int.random(in: 1...4)
            n2 = 2
        case 2:
            n1 = 2 * Int.random(in: 1...4) * 100 +
                 2 * Int.random(in: 1...4) * 10 +
                 2 * Int.random(in: 1...4)
            n2 = 2
        case 3:
            n1 = 3 * Int.random(in: 1...3) * 100 +
                 3 * Int.random(in: 1...3) * 10 +
                 3 * Int.random(in: 1...3)
            n2 = 3
        case 4:
            n1 = (4 * Int.random(in: 1...4) + 1) * 10 + 2 * Int.random(in: 0...4)
            n2 = 2
        case 5:
            n1 = Int.random(in: 11...19) * 5
            n2 = 5
        case 6:
            n2 = Int.random(in: 6...9)
            n1 = n2 * Int.random(in: 6...9)
        case 7:
            n1 = Int.random(in: 1...3) * 30 + Int.random(in: 4...9) * 3
            n2 = 3
        case 8:
            n1 = Int.random(in: 2...9) * 50 + Int.random(in: 2...9) * 5
            n2 = 5
        case 9:
            n1 = Int.random(in: 4...9) * 30 + Int.random(in: 4...9) * 3
            n2 = 3
        case 10:
            n1 = Int.random(in: 3...9) * 40 + Int.random(in: 3...9) * 4
            n2 = 4
        case 11:
            n1 = Int.random(in: 2...9) * 60 + Int.random(in: 2...9) * 6
            n2 = 6
        case 12:
            n1 = Int.random(in: 2...9) * 70 + Int.random(in: 2...9) * 7
            n2 = 7
        case 13:
            n1 = Int.random(in: 2...9) * 80 + Int.random(in: 2...9) * 8
            n2 = 8
        case 14:
            n1 = Int.random(in: 2...9) * 90 + Int.random(in: 2...9) * 9
            n2 = 9
        case 15:
            n2 = Int.random(in: 11...15)
            n1 = Int.random(in: 2...4) * 10 * n2 + Int.random(in: 2...4) * n2
        default:
            return nil
        }
        return .init(firstNumber: n1, secondNumber: n2)
    }
}
