//
//  PasswordChangeAssembly.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 25.12.2021.
//

import Foundation

final class PasswordChangeAssembly {
    static func build() -> Presentable & PasswordChangeViewInput {
        let view = PasswordChangeViewController()
        let presenter = PasswordChangePresenter(view: view)
        view.presenter = presenter
        return view
    }
}
