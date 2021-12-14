//
//  SignInAssembly.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 14.12.2021.
//

import UIKit

enum SignInAssembly {
    static func build() -> UIViewController {
        let view = SignInViewController()
        let presenter = SignInPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
