//
//  ActivityStrategy.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 29.12.2021.
//

import Foundation

protocol ActivityStrategy {
    func generate(level: Int) -> InputData?
}

extension ActivityStrategy {
    /// Function that returns the n digit of X (from right side)
    func getDigit(from x: Int, at n: Int) -> Int {
        let num = String(x).compactMap { $0.wholeNumberValue }
        return num[num.count - n]
    }
}
