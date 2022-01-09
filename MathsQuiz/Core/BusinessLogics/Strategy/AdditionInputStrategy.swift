//
//  AdditionInputStrategy.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 29.12.2021.
//

import Foundation

final class AdditionActivityStrategy: ActivityStrategy {
    
    func generate(level: Int) -> Input? {
        switch level {
        case 1:
            let sum = Int.random(in: 6...9)
            let n1 = Int.random(in: 1..<sum)
            let n2 = sum - n1
            return .init(firstNumber: n1, secondNumber: n2)
        case 2:
            let sum = Int.random(in: 11...19)
            let n1 = Int.random(in: 10..<sum)
            let n2 = sum - n1
            return .init(firstNumber: n1, secondNumber: n2)
        case 3:
            let sum = Int.random(in: 10...12)
            let n1 = Int.random(in: (sum - 9)..<9)
            let n2 = sum - n1
            return .init(firstNumber: n1, secondNumber: n2)
        default:
            return nil
        }
    }
}

class ExampleFactory {
    var strategy: ActivityStrategy
    
    init?(activity: ActivityType) {
        switch activity {
        case .addition:
            strategy = AdditionActivityStrategy()
        default:
            return nil
        }
       
        let input = strategy.generate(level: 1)
    }
}
