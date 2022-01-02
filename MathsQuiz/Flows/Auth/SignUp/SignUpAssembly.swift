//
//  SignUpAssembly.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 15.12.2021.
//

import UIKit

final class SignUpAssembly {
    static func build() -> SignUpViewInput & Presentable {
        let view = SignUpViewController()
        let presenter = SignUpPresenter(view: view,
                                        authService: FirebaseAuthService(),
                                        firestoreManager: FirestoreManager())
        view.presenter = presenter
        return view
    }
}
