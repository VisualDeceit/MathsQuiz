//
//  ExampleResolver.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 04.01.2022.
//

import Foundation

class ExampleResolver: Resolver {
    private var input: Input
    private var type: ActivityType
    
    required init(input: Input, type: ActivityType) {
        self.input = input
        self.type = type
    }
    
    func resolve() -> ResolveResult {
        switch type {
        case .addition:
            return additionHandler()
        case .subtraction:
            return subtractionHandler()
        case .multiplication:
            return multiplicationHandler()
        case .division:
            return divisionHandler()
        case .expression:
           return expressionHandler()
        }
    }
}

private extension ExampleResolver {
    func additionHandler() -> ResolveResult {
        ResolveResult()
    }
    
    func subtractionHandler() -> ResolveResult {
        ResolveResult()
    }
    
    func multiplicationHandler() -> ResolveResult {
        ResolveResult()
    }
    
    func divisionHandler() -> ResolveResult {
        ResolveResult()
    }
    
    func expressionHandler() -> ResolveResult {
        ResolveResult()
    }
}
