//
//  SignUpContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 17.12.2021.
//

import Foundation

protocol SignUpPresenterOutput {
    var onSignUpComplete: (() -> Void)? { get set }
    var onLoginButtonTap: (() -> Void)? { get set }
}
protocol SignUpViewOutput: AnyObject {
    init(view: SignUpViewInput)

    func signUpButtonTapped(data: SignUpData)
    func signInButtonTapped()
}

protocol SignUpViewInput: AnyObject {
    var presenter: (SignUpViewOutput & SignUpPresenterOutput)? { get set }
    
    func needShowAlert(title: String, message: String?)
}


