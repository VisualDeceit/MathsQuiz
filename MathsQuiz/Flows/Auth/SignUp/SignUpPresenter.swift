//
//  SignUpPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 15.12.2021.
//

import Foundation
import FirebaseAuth

class SignUpPresenter: SignUpPresenterOutput {

    var onSignUpComplete: (() -> Void)?
    var onLoginButtonTap: (() -> Void)?
    
    var authService: AuthorizationService
    var firestoreManager: StorageManager
    
    private(set) weak var view: SignUpViewInput?
    
    required init(view: SignUpViewInput, authService: AuthorizationService, firestoreManager: StorageManager) {
        self.view = view
        self.authService = authService
        self.firestoreManager = firestoreManager
    }
    
    private func createUser(from data: SignUpData) {
        guard !data.email.isEmpty else {
            self.view?.displayAlert("Пожалуйста, введите действующий адрес электронной почты")
            return
        }
        
        guard !data.password.isEmpty else {
            self.view?.displayAlert("Пожалуйста, введите пароль")
            return
        }
        
        guard !data.passwordConfirm.isEmpty else {
            self.view?.displayAlert("Пожалуйста, введите подтверждение пароля")
            return
        }
        
        guard data.password == data.passwordConfirm else {
            self.view?.displayAlert("Подтверждение пароля не совпадает с паролем")
            return
        }
        
        authService.createUser(with: data.email, password: data.password) {[weak self] result in
            switch result {
            case .success(let loginResult):
                Session.uid = loginResult.user.uid
                let name = self?.splitOnFirstAndLast(name: data.username)
                let profile = UserProfile(email: data.email,
                                          phone: nil,
                                          city: nil,
                                          lastName: name?.last,
                                          firstName: name?.first,
                                          sex: nil,
                                          birthday: nil)
                
                do {
                    try self?.firestoreManager.saveUserProfile(profile: profile)
                } catch let error {
                    self?.authService.deleteCurrentUser { _ in }
                    Session.uid = nil
                    self?.view?.displayAlert(error.localizedDescription)
                    return
                }
                self?.onSignUpComplete?()
            case .failure(let error):
                let errCode = AuthErrorCode(rawValue: error._code)
                self?.view?.displayAlert(errCode?.errorMessage)
            }
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
