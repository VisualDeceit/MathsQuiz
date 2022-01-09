//
//  ActivityStrategy.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 29.12.2021.
//

import Foundation

protocol ActivityStrategy {
    func generate(level: Int) -> Input?
}
