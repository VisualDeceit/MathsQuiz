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
    
    init(input: Input, type: ActivityType) {
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
        
        let firstNumber = String(input.firstNumber)
            .reversed()
            .compactMap { Int(String($0)) }
        
        let secondNumber = String(input.secondNumber)
            .reversed()
            .compactMap { Int(String($0)) }
        
        let digitCount = max(firstNumber.count, secondNumber.count)
        
        var carry = 0
        var result = ResolveResult(firstNumber: [], secondNumber: [], solution: [])
        
        for i in 0..<digitCount {
            var d1 = 0
            var d2 = 0
            
            if i >= 0 && i < firstNumber.count {
                d1 = firstNumber[i]
                result.firstNumber.append(Digit(value: d1, carry: carry))
            }
            
            if i >= 0 && i < secondNumber.count {
                d2 = secondNumber[i]
                if i > firstNumber.count - 1 {
                    result.secondNumber.append(Digit(value: d2, carry: carry))
                } else {
                    result.secondNumber.append(Digit(value: d2, carry: 0))
                }
            }
            
            var sum = d1 + d2 + carry
            if sum > 9 {
                carry = 1
                sum -= 10
            } else {
                carry = 0
            }
            
            result.solution.append(Digit(value: sum, carry: 0))
        }
        
        if carry == 1 {
            result.solution.append(Digit(value: 1, carry: 0))
        }
        
        result.firstNumber.reverse()
        result.secondNumber.reverse()
        result.solution.reverse()
        
        return result
    }
    
    func subtractionHandler() -> ResolveResult {
        ResolveResult(firstNumber: [], secondNumber: [], solution: [])
    }
    
    func multiplicationHandler() -> ResolveResult {
        ResolveResult(firstNumber: [], secondNumber: [], solution: [])
    }
    
    func divisionHandler() -> ResolveResult {
        ResolveResult(firstNumber: [], secondNumber: [], solution: [])
    }
    
    func expressionHandler() -> ResolveResult {
        ResolveResult(firstNumber: [], secondNumber: [], solution: [])
    }
}
