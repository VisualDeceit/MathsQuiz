//
//  DateFormatter+Extension.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 01.01.2022.
//

import Foundation

extension  DateFormatter {
    static let shortLocalStyle: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale.current
        df.dateStyle = .short
        df.timeStyle = .none
        df.dateFormat = "dd.MM.yyyy"
        return df
    }()
}
