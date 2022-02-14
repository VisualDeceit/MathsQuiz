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
    var solution: ResolveResult { get }
    
    func makeAdditionExample(for level: Level) -> UIView?
    func makeSubtractionExample(for level: Level) -> UIView?
}

final class MainExampleFactory: ExampleFactory {
    
    let type: ActivityType
    let resolver: Resolver
    let strategy: ActivityStrategy
    
    var solution = ResolveResult()
    
    init(strategy: ActivityStrategy, resolver: Resolver) {
        self.strategy = strategy
        self.resolver = resolver
        self.type = resolver.type
    }
    
    func makeAdditionExample(for level: Level) -> UIView? {
       makeBaseExample(for: level)
    }
    
    func makeSubtractionExample(for level: Level) -> UIView? {
        makeBaseExample(for: level)
    }
    
    private func makeBaseExample(for level: Level) -> UIView? {
        guard let input = strategy.generate(level: level.number) else {
            return nil
        }
        
        solution = resolver.resolve(input: input)
        
        let builder = ExampleViewBuilder()
        builder.addNewRow()

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
        
        solution.result.sorted { $0.key > $1.key }.forEach { index, _ in
            builder.addDigit(Digit(), type: .result, index: index)
        }

        let exampleView = builder.build()
        
        return exampleView
    }
}
