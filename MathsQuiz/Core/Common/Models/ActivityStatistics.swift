//
//  ActivityStatistics.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 02.02.2022.
//

import Foundation

struct ActivityStatistics: Codable {
    let totalScore: Int
    let completion: Int
    let time: Int
}
