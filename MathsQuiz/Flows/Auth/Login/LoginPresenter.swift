//
//  LoginPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 14.12.2021.
//

import Foundation

class LoginPresenter: LoginViewOutput, LoginPresenterOutput {
    
    private(set) weak var view: LoginViewInput?
    
    var onCompleteAuth: (() -> Void)?
    var onSignUpButtonTap: (() -> Void)?
    
    required init(view: LoginViewInput) {
        self.view = view
    }

    func forgotPasswordButtonTapped() {
        print(#function)
    }
    
    func googleButtonTapped() {
        print(#function)
    }
    
    func appleButtonTapped() {
        print(#function)
    }
    
    func facebookButtonTapped() {
        print(#function)
    }
    
    func createNewAccountButtonTapped() {
        // implementation stub
        onSignUpButtonTap?()
    }
    
    func loginButtonTapped() {
        // implementation stub
        onCompleteAuth?()
    }
}
