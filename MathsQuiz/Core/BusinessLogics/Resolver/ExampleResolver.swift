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

    func resolve(input: InputData) -> ResolveResult {
        switch type {
        case .addition:
            return additionHandler(input: input)
        case .subtraction:
            return subtractionHandler(input: input)
        case .multiplication:
            return multiplicationHandler(input: input)
        case .division:
            return divisionHandler(input: input)
        case .expression:
            return expressionHandler()
        }
    }
}

private extension ExampleResolver {
    
    func additionHandler(input: InputData) -> ResolveResult {
        
        let firstNumber = String(input.firstNumber)
            .reversed()
            .compactMap { Int(String($0)) }
        
        let secondNumber = String(input.secondNumber)
            .reversed()
            .compactMap { Int(String($0)) }
        
        let digitCount = max(firstNumber.count, secondNumber.count)
        
        var carry = 0
        var output = ResolveResult()
        
        for index in 0..<digitCount {
            var d1 = 0
            var d2 = 0
            
            if index >= 0 && index < firstNumber.count {
                d1 = firstNumber[index]
                output.firstNumber.append(Digit(value: d1, carry: carry))
            }
            
            if index >= 0 && index < secondNumber.count {
                d2 = secondNumber[index]
                if index > firstNumber.count - 1 {
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
            
            output.result[index] = Digit(value: sum, carry: 0)
        }
        
        if carry == 1 {
            output.result[digitCount] = Digit(value: 1, carry: 0)
        }
        
        output.firstNumber.reverse()
        output.secondNumber.reverse()
        
        return output
    }
    
    func subtractionHandler(input: InputData) -> ResolveResult {
        
        let firstNumber = String(input.firstNumber)
            .reversed()
            .compactMap { Int(String($0)) }
        
        let secondNumber = String(input.secondNumber)
            .reversed()
            .compactMap { Int(String($0)) }
        
        let digitCount = max(firstNumber.count, secondNumber.count)
        
        var carry = 0
        var output = ResolveResult()
        
        for index in 0..<digitCount {
            var d1 = 0
            var d2 = 0
            
            if index >= 0 && index < firstNumber.count {
                d1 = firstNumber[index]
                output.firstNumber.append(Digit(value: d1, carry: carry))
            }
            
            if index >= 0 && index < secondNumber.count {
                d2 = secondNumber[index]
                if index > firstNumber.count - 1 {
                    output.secondNumber.append(Digit(value: d2, carry: carry))
                } else {
                    output.secondNumber.append(Digit(value: d2, carry: 0))
                }
            }
            
            var diff = d1 - d2 - carry
            if diff < 0 {
                carry = 1
                diff += 10
            } else {
                carry = 0
            }
            
            if index == (digitCount - 1), diff == 0 {
                break
            }
            
            output.result[index] = Digit(value: diff, carry: 0)
        }
        
        output.firstNumber.reverse()
        output.secondNumber.reverse()
        
        return output
    }
    
    func multiplicationHandler(input: InputData) -> ResolveResult {
        
        let firstNumber = String(input.firstNumber)
            .reversed()
            .compactMap { Int(String($0)) }
        
        let secondNumber = String(input.secondNumber)
            .reversed()
            .compactMap { Int(String($0)) }
        
        var output = ResolveResult()
        
        for secondIndex in 0..<secondNumber.count {
            let secondNumberDigit = secondNumber[secondIndex]
            var carry = 0
            output.secondNumber.append(Digit(value: secondNumberDigit, carry: 0))
            
            for firstIndex in 0..<firstNumber.count {
                let firstNumberDigit = firstNumber[firstIndex]
                if secondIndex == 0 {
                    output.firstNumber.append(Digit(value: firstNumberDigit, carry: carry))
                }
                
                let multi = firstNumberDigit * secondNumberDigit + carry
                output.result[secondIndex * 10 + firstIndex + secondIndex] = Digit(value: multi % 10,
                                                                                   carry: 0)
                carry = multi / 10
            }
            
            if carry > 0 {
                output.result[secondIndex * 10 + firstNumber.count] = Digit(value: carry, carry: 0)
            }
        }
        
        if firstNumber.count > 1 && secondNumber.count > 1 {
            let resultNumber = String(input.firstNumber * input.secondNumber)
                .reversed()
                .compactMap { Int(String($0)) }
            
            for resultIndex in 0..<resultNumber.count {
                output.result[(secondNumber.count + 1) * 10 + resultIndex] =
                    Digit(value: resultNumber[resultIndex], carry: 0)
            }
        }
        
        output.firstNumber.reverse()
        output.secondNumber.reverse()
        return output
    }
    
    func divisionHandler(input: InputData) -> ResolveResult {
        ResolveResult()
    }
    
    func expressionHandler() -> ResolveResult {
        ResolveResult()
    }
}
