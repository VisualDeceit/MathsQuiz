//
//  SignUpAssembly.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 15.12.2021.
//

import UIKit

enum SignUpAssembly {
    static func build() -> UIViewController {
        let view = SignUpViewController()
        let presenter = SignUpPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
