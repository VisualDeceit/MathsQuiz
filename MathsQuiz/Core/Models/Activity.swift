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
}

struct Activity {
    var type: ActivityType
    var progress: Int // прогресс активности
    var total: Int // всего уровней
}
