//
//  String+Extension.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 24.12.2021.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "Ru_ru")
        formatter.dateFormat = "dd.MM.yyyy"
        return  formatter.date(from: self)
    }
}
