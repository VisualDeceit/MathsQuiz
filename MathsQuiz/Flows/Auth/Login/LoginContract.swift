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
    func viewDidPasswordResetButtonTap()
    func viewDidGoogleButtonTap()
    func viewDidAppleButtonTap()
    func viewDidFacebookButtonTap()
    func viewDidSignUpTap()
    func viewDidLoginButtonTap(credentials: Credentials)
}

protocol LoginViewInput: AnyObject {
    var presenter: (LoginViewOutput & LoginPresenterOutput)? { get set }
    
    func needShowAlert(title: String, message: String?)
}
