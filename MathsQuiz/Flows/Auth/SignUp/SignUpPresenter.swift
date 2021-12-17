//
//  SignUpPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 15.12.2021.
//

import Foundation

class SignUpPresenter: SignUpViewOutput, SignUpPresenterOutput {
    
    private(set) weak var view: SignUpViewInput?
    
    var onSignUpComplete: (() -> Void)?
    var onLoginButtonTap: (() -> Void)?
    
    required init(view: SignUpViewInput) {
        self.view = view
    }
    
    func signUpButtonTapped() {
        print(#function)
        onSignUpComplete?()
    }
    
    func signInButtonTapped() {
        print(#function)
        onLoginButtonTap?()
    }
}
