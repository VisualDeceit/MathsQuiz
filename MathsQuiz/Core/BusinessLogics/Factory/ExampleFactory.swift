//
//  ExampleFactory.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 05.01.2022.
//

import Foundation

protocol ExampleFactory {
    var type: ActivityType { get }
    var resolver: Resolver { get }
    var strategy: ActivityStrategy { get }
    
    func makeAdditionExample(for level: Level) -> Example?
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
    
    func makeAdditionExample(for level: Level) -> Example? {
        guard let input = strategy.generate(level: level.number) else {
            return nil
        }
        
        let solution = resolver.resolve(input: input)
        
        return nil
    }
}
