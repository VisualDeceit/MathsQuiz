//
//  SignInPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 14.12.2021.
//

import Foundation

///SignIn view output interface
protocol SignInViewOutput: AnyObject {
    init(view: SignInViewInput)
    func forgotPasswordButtonTapped()
    func googleButtonTapped()
    func appleButtonTapped()
    func facebookButtonTapped()
    func createNewAccountButtonTapped()
    func loginButtonTapped()
}

class SignInPresenter: SignInViewOutput {
    private(set) weak var view: SignInViewInput?
    
    required init(view: SignInViewInput) {
        self.view = view
    }

    //Обработка команд от view
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
        print(#function)
    }
    
    func loginButtonTapped() {
        print(#function)
    }
}
