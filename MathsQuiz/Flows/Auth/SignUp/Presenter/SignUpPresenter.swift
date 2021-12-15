//
//  SignUpPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 15.12.2021.
//

import Foundation
///SignUp view output interface
protocol SignUpViewOutput: AnyObject {
    init(view: SignUpViewInput)
    func signUpButtonTapped()
    func signInButtonTapped()
}

class SignUpPresenter: SignUpViewOutput {
    private(set) weak var view: SignUpViewInput?
    
    required init(view: SignUpViewInput) {
        self.view = view
    }
    
    func signUpButtonTapped() {
        print(#function)
    }
    
    func signInButtonTapped() {
        print(#function)
    }
}
