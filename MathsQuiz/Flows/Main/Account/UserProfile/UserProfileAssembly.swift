//
//  UserAccountAssembly.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 20.12.2021.
//

import Foundation

final class UserProfileAssembly {
    static func build() -> UserProfileViewInput & Presentable {
        let view = UserProfileViewController()
        let presenter = UserProfilePresenter(view: view)
        view.presenter = presenter
        return view
    }
}
