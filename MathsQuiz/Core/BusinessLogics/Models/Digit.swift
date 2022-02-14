//
//  Digit.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 30.12.2021.
//

import Foundation

struct Digit: Equatable, Hashable {
    let value: Int
    let carry: Int
}

extension Digit {
    init() {
        value = 0
        carry = 0
    }
}
