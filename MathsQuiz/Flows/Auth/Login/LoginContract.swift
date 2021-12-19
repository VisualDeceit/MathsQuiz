//
//  LoginContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 17.12.2021.
//

// Здесь описаны все интерфейсы для реализации архитектуры MVP

import Foundation

protocol LoginPresenterOutput: AnyObject {
    var onCompleteAuth: (() -> Void)? { get set }
    var onSignUpButtonTap: (() -> Void)? { get set }
}

protocol LoginViewOutput: AnyObject {
    func forgotPasswordButtonTapped()
    func googleButtonTapped()
    func appleButtonTapped()
    func facebookButtonTapped()
    func onCreateNewAccountButtonTapped()
    func onLoginButtonTapped(credentials: Credentials)
}

protocol LoginViewInput: AnyObject {
    var presenter: (LoginViewOutput & LoginPresenterOutput)? { get set }
    
    func needShowAlert(title: String, message: String?)
}
