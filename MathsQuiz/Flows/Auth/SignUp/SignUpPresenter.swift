//
//  SignUpPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 15.12.2021.
//

import Foundation
import FirebaseAuth

class SignUpPresenter: SignUpPresenterOutput {

    private(set) weak var view: SignUpViewInput?
    
    var onSignUpComplete: (() -> Void)?
    var onLoginButtonTap: (() -> Void)?
    
    required init(view: SignUpViewInput) {
        self.view = view
    }
    
    private func createUser(from data: SignUpData) {
        guard !data.email.isEmpty else {
            self.view?.needShowAlert(title: "Ошибка",
                                     message: "Пожалуйста, введите действующий адрес электронной почты")
            return
        }
        
        guard !data.password.isEmpty else {
            self.view?.needShowAlert(title: "Ошибка",
                                     message: "Пожалуйста, введите пароль")
            return
        }
        
        guard !data.passwordConfirm.isEmpty else {
            self.view?.needShowAlert(title: "Ошибка",
                                     message: "Пожалуйста, введите подтверждение пароля")
            return
        }
        
        guard data.password == data.passwordConfirm else {
            self.view?.needShowAlert(title: "Ошибка",
                                     message: "Подтверждение пароля не совпадает с паролем")
            return
        }
 
        Auth.auth().createUser(withEmail: data.email,
                               password: data.password) { [weak self] (authResult, error) in
            guard let authResult = authResult, error == nil else {
                if let error = error,
                   let errCode = AuthErrorCode(rawValue: error._code) {
                    self?.view?.needShowAlert(title: "Ошибка",
                                              message: errCode.errorMessage)
                }
                return
            }
            UserDefaultsWrapper.uid = authResult.user.uid
            // TODO - Добавить пользователя в БД
            self?.onSignUpComplete?()
        }
    }
}

    // MARK: - SignUpViewOutput
extension SignUpPresenter: SignUpViewOutput {
    
    func onSignUpButtonTapped(data: SignUpData) {
        createUser(from: data)
    }
    
    func onLoginButtonTapped() {
        onLoginButtonTap?()
    }
}
