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
            
            Session.uid = authResult.user.uid
            
            // Добавить пользователя в БД
            let name = self?.splitOnFirstAndLast(name: data.username)
            let profile = UserProfile(email: data.email,
                                      phone: nil,
                                      city: nil,
                                      lastName: name?.last,
                                      firstName: name?.first,
                                      sex: .female,
                                      birthday: nil)
            
            do {
                try FirestoreManager.shared.saveUser(uid: authResult.user.uid, profile: profile)
            } catch let error {
                // delete user
                let user = Auth.auth().currentUser
                user?.delete()
                Session.uid = nil
                self?.view?.needShowAlert(title: "Ошибка",
                                          message: error.localizedDescription)
                return
            }
            self?.onSignUpComplete?()
        }
    }
    
    private func splitOnFirstAndLast(name: String) -> (first: String, last: String) {
        var firstName = ""
        var lastName = ""
        var components = name.components(separatedBy: " ")
        if !components.isEmpty {
            firstName = components.removeFirst()
            lastName = components.joined(separator: " ")
        } else {
            firstName = name
        }
        return (firstName, lastName)
    }
}

// MARK: - SignUpViewOutput
extension SignUpPresenter: SignUpViewOutput {
    
    func viewDidSignUpButtonTap(data: SignUpData) {
        createUser(from: data)
    }
    
    func viewDidLoginButtonTap() {
        onLoginButtonTap?()
    }
}
