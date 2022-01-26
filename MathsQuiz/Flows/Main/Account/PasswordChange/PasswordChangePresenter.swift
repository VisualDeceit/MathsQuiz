//
//  PasswordChangePresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 25.12.2021.
//

import Foundation
import FirebaseAuth

final class PasswordChangePresenter: PasswordChangeViewOutput, PasswordChangePresenterOutput {
    
    let authService: AuthorizationService
    
    var onSuccess: (() -> Void)?
    
    private weak var view: PasswordChangeViewInput?
    
    init(view: PasswordChangeViewInput, authService: AuthorizationService) {
        self.view = view
        self.authService = authService
    }
    
    func viewDidChangePasswordButtonTap(_ passwordPair: PasswordPair) {
        let password: String = passwordPair.password ?? ""
        let confirm: String = passwordPair.confirm ?? ""
        
        guard !password.isEmpty else {
            self.view?.displayAlert("Пожалуйста, введите пароль")
            return
        }
        
        guard !confirm.isEmpty else {
            self.view?.displayAlert("Пожалуйста, введите подтверждение пароля")
            return
        }
        
        guard password == confirm else {
            self.view?.displayAlert("Подтверждение пароля не совпадает с паролем")
            return
        }
        
        changePassword(newPassword: password)
    }
    
    private func changePassword(newPassword: String) {
        authService.updatePassword(to: newPassword) {[weak self] error in
            if let error = error {
                let errCode = AuthErrorCode(rawValue: error._code)
                self?.view?.displayAlert(errCode?.errorMessage)
                return
            }
            self?.authService.signOut {[weak self] error in
                if let error = error {
                    self?.view?.displayAlert(error)
                    return
                }
            }
            Session.uid = nil
            self?.onSuccess?()
        }
    }
}
