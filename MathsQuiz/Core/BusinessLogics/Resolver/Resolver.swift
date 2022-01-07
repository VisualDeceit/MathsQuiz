//
//  Resolver.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 04.01.2022.
//

import Foundation

protocol Resolver {
    var type: ActivityType { get }
    func resolve(input: Input) -> ResolveResult
}
