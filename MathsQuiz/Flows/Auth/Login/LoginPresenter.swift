//
//  LoginPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 14.12.2021.
//

import Foundation
import Firebase

class LoginPresenter: LoginPresenterOutput {
    
    private(set) weak var view: LoginViewInput?
    
    var onCompleteAuth: (() -> Void)?
    var onSignUpButtonTap: (() -> Void)?
    
    required init(view: LoginViewInput) {
        self.view = view
    }
    
    private func login(with credentials: Credentials) {
        Auth.auth().signIn(withEmail: credentials.email, password: credentials.password) { [weak self] loginResult, error in
            guard let loginResult = loginResult, error == nil else {
                if let error = error,
                   let errCode = AuthErrorCode(rawValue: error._code) {
                    self?.view?.needShowAlert(title: "Ошибка",
                                              message: errCode.errorMessage)
                }
                return
            }
            UserDefaultsWrapper.uid = loginResult.user.uid
            print("User email: \(String(describing: loginResult.user.email))")
            self?.onCompleteAuth?()
        }
    }
}

// MARK: - LoginViewOutput
extension LoginPresenter: LoginViewOutput {
    
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
    
    func onCreateNewAccountButtonTapped() {
        onSignUpButtonTap?()
    }
    
    func onLoginButtonTapped(credentials: Credentials) {
        login(with: credentials)
    }
}
