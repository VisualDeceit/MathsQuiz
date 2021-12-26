//
//  PasswordResetAssembly.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 26.12.2021.
//

import Foundation

final class PasswordResetAssembly {
    
    static func build() -> Presentable & PasswordResetViewInput {
        let view = PasswordResetViewController()
        let presenter = PasswordResetPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
