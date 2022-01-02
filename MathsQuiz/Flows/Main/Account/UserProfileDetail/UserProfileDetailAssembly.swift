//
//  UserDataAssembly.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 20.12.2021.
//

import Foundation

final class UserProfileDetailAssembly {
    static func build() -> UserProfileDetailViewInput & Presentable {
        let view = UserProfileDetailViewController()
        let presenter = UserProfileDetailPresenter(view: view, firestoreManager: FirestoreManager())
        view.presenter = presenter
        return view
    }
}
