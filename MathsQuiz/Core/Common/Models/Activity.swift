//
//  Activity.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 19.12.2021.
//

import UIKit

enum ActivityType: String, Codable, CaseIterable {
    case addition = "Cложение"
    case subtraction = "Вычитание"
    case multiplication = "Умножение"
    case division = "Деление"
    case expression = "Выражения"
    
    var sign: String {
        switch self {
        case .addition:
            return "+"
        case .subtraction:
            return "-"
        case .multiplication:
            return "x"
        default:
            return ""
        }
    }
    
    var totalLevels: Int {
        switch self {
        case .addition:
            return AdditionActivityStrategy.total
        case .subtraction:
            return SubtractionActivityStrategy.total
        case .multiplication:
            return MultiplicationActivityStrategy.total
        case .division:
            return 0
        case .expression:
            return 0
        }
    }
    
    var color: UIColor {
        switch self {
        case .addition:
            return  MQColor.lavenderLight
        case .subtraction:
            return MQColor.pictonBlueLight
        case .multiplication:
            return MQColor.moonstoneBlueLight
        case .division:
            return MQColor.jasperOrangeLight
        case .expression:
            return MQColor.candyPinkLight
        }
    }
    
    var highlightedColor: UIColor {
        switch self {
        case .addition:
            return  MQColor.lavenderDark
        case .subtraction:
            return MQColor.pictonBlueDark
        case .multiplication:
            return MQColor.moonstoneBlueDark
        case .division:
            return MQColor.jasperOrangeDark
        case .expression:
            return MQColor.candyPinkDark
        }
    }
}

struct Activity: Codable, Hashable {
    let index: Int
    let type: ActivityType
}
