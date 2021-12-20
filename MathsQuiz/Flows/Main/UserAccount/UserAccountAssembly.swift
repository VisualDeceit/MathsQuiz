//
//  UserAccountAssembly.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 20.12.2021.
//

import Foundation

final class UserAccountAssembly {
    static func build() -> UserAccountViewInput & Presentable {
        let view = UserAccountViewController()
        let presenter = UserAccountPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
