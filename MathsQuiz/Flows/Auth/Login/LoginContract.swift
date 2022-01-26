//
//  LoginContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 17.12.2021.
//

// Здесь описаны все интерфейсы для реализации архитектуры MVP

import Foundation

enum AuthProvider {
    case google, apple, facebook, emailPassword
}

protocol LoginViewInput: AnyObject, Alertable {
    var presenter: (LoginViewOutput & LoginPresenterOutput)? { get set }
}

protocol LoginViewOutput: AnyObject {
    func viewDidSignInButtonTap(provider: AuthProvider, credentials: Credentials?)
    func viewDidPasswordResetButtonTap()
    func viewDidSignUpTap()
}

protocol LoginPresenterOutput: AnyObject {
    var onCompleteAuth: (() -> Void)? { get set }
    var onSignUpButtonTap: (() -> Void)? { get set }
    var onPasswordReset: (() -> Void)? { get set }
}
