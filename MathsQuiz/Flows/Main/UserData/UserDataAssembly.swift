//
//  UserDataAssembly.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 20.12.2021.
//

import Foundation

final class UserDataAssembly {
    static func build() -> UserDataViewInput & Presentable {
        let view = UserDataViewController()
        let presenter = UserDataPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
