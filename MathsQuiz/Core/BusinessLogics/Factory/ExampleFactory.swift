//
//  ExampleFactory.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 05.01.2022.
//

import UIKit

protocol ExampleFactory {
    var type: ActivityType { get }
    var resolver: Resolver { get }
    var strategy: ActivityStrategy { get }
    
    func makeAdditionExample(for level: Level) -> UIView?
}

final class MainExampleFactory: ExampleFactory {
    
    let type: ActivityType
    let resolver: Resolver
    let strategy: ActivityStrategy
    
    init(strategy: ActivityStrategy, resolver: Resolver) {
        self.strategy = strategy
        self.resolver = resolver
        self.type = resolver.type
    }
    
    func makeAdditionExample(for level: Level) -> UIView? {
        guard let input = strategy.generate(level: level.number) else {
            return nil
        }
        
        let solution = resolver.resolve(input: input)
        
        let builder = ExampleViewBuilder()
        builder.addNewRow()
        
//        let userResult = Array(repeating: Digit(value: 0, carry: 0), count: solution.result.count)

        for digit in solution.firstNumber {
            builder.addDigit(digit, type: .common, index: 0)
        }
        
        builder.addNewRow()
        builder.addSign(type)
        
        solution.secondNumber.forEach { (digit) in
            builder.addDigit(digit, type: .common, index: 0)
        }
        
        builder.addSeparator(for: String(input.secondNumber).count + 1)
        builder.addNewRow()
        
        for index in solution.result.indices {
            builder.addDigit(Digit(value: 0, carry: 0), type: .result, index: index)
        }
        
        let exampleView = builder.build()
        
        return exampleView
    }
}
