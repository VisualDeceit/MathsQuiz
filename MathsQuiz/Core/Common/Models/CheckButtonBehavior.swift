//
//  CheckButton.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 17.01.2022.
//

import Foundation

enum CheckButtonBehavior: String {
    case check = "Проверить"
    case transition = "Далее"
    case finish = "Завершить"
    
    var title: String {
        self.rawValue
    }
}
