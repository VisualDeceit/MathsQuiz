//
//  Activity.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 19.12.2021.
//

import UIKit

enum ActivityType: String {
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
    
    var highlightedСolor: UIColor {
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

struct Activity {
    let type: ActivityType
    let progress: Int // прогресс активности
    let total: Int // всего уровней
}
