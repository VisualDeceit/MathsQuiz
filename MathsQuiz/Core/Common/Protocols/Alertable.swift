//
//  Alertable.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 21.01.2022.
//

import Foundation

protocol Alertable {
    func displayAlert(_ message: String?)
}

extension Alertable {
    func displayAlert(_ error: Error) {
        displayAlert(error.localizedDescription)
    }
}
