//
//  SignInAssembly.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 14.12.2021.
//

// Сборщик модулей под архитектуру

import UIKit

final class LoginAssembly {
    static func build() -> LoginViewInput & Presentable {
        let view = LoginViewController()
        let presenter = LoginPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
