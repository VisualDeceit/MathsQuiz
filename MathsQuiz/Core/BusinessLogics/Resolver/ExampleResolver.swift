//
//  ExampleResolver.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 04.01.2022.
//

import Foundation

class ExampleResolver: Resolver {
    let type: ActivityType
    
    init(type: ActivityType) {
        self.type = type
    }

    func resolve(input: Input) -> ResolveResult {
        switch type {
        case .addition:
            return additionHandler(input: input)
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
    
    func additionHandler(input: Input) -> ResolveResult {
        
        let firstNumber = String(input.firstNumber)
            .reversed()
            .compactMap { Int(String($0)) }
        
        let secondNumber = String(input.secondNumber)
            .reversed()
            .compactMap { Int(String($0)) }
        
        let digitCount = max(firstNumber.count, secondNumber.count)
        
        var carry = 0
        var output = ResolveResult(firstNumber: [], secondNumber: [], result: [])
        
        for i in 0..<digitCount {
            var d1 = 0
            var d2 = 0
            
            if i >= 0 && i < firstNumber.count {
                d1 = firstNumber[i]
                output.firstNumber.append(Digit(value: d1, carry: carry))
            }
            
            if i >= 0 && i < secondNumber.count {
                d2 = secondNumber[i]
                if i > firstNumber.count - 1 {
                    output.secondNumber.append(Digit(value: d2, carry: carry))
                } else {
                    output.secondNumber.append(Digit(value: d2, carry: 0))
                }
            }
            
            var sum = d1 + d2 + carry
            if sum > 9 {
                carry = 1
                sum -= 10
            } else {
                carry = 0
            }
            
            output.result.append(Digit(value: sum, carry: 0))
        }
        
        if carry == 1 {
            output.result.append(Digit(value: 1, carry: 0))
        }
        
        output.firstNumber.reverse()
        output.secondNumber.reverse()
        output.result.reverse()
        
        return output
    }
    
    func subtractionHandler() -> ResolveResult {
        ResolveResult(firstNumber: [], secondNumber: [], result: [])
    }
    
    func multiplicationHandler() -> ResolveResult {
        ResolveResult(firstNumber: [], secondNumber: [], result: [])
    }
    
    func divisionHandler() -> ResolveResult {
        ResolveResult(firstNumber: [], secondNumber: [], result: [])
    }
    
    func expressionHandler() -> ResolveResult {
        ResolveResult(firstNumber: [], secondNumber: [], result: [])
    }
}
