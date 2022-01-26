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
    func viewDidSignUpButtonTap(data: SignUpData)
    func viewDidLoginButtonTap()
}

protocol SignUpViewInput: AnyObject, Alertable {
    var presenter: (SignUpViewOutput & SignUpPresenterOutput)? { get set }
}
