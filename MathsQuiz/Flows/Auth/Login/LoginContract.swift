//
//  LoginContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 17.12.2021.
//

// Здесь описаны все интерфейсы для реализации архитектуры MVP

import Foundation

protocol LoginViewInput: AnyObject {
    var presenter: (LoginViewOutput & LoginPresenterOutput)? { get set }
}

protocol LoginViewOutput: AnyObject {
    init(view: LoginViewInput)
    
    func forgotPasswordButtonTapped()
    func googleButtonTapped()
    func appleButtonTapped()
    func facebookButtonTapped()
    func createNewAccountButtonTapped()
    func loginButtonTapped()
}

protocol LoginPresenterOutput: AnyObject {
    var onCompleteAuth: (() -> Void)? { get set }
    var onSignUpButtonTap: (() -> Void)? { get set }
}
