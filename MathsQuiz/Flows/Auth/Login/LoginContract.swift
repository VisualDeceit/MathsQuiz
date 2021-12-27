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

protocol LoginViewInput: AnyObject {
    var presenter: (LoginViewOutput & LoginPresenterOutput)? { get set }
    func displayAlert(_ message: String?)
}

protocol LoginViewOutput: AnyObject {
    func viewDidSignInButtonTap(provider: AuthProvider, credentials: Credentials?)
    func viewDidPasswordResetButtonTap()
    func viewDidSignUpTap()
}

protocol LoginPresenterOutput: AnyObject {
    var onCompleteAuth: CompletionBlock? { get set }
    var onSignUpButtonTap: CompletionBlock? { get set }
    var onPasswordReset: CompletionBlock? { get set }
}
