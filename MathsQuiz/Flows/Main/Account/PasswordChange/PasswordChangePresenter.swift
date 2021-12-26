//
//  PasswordChangePresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 25.12.2021.
//

import Foundation
import FirebaseAuth

final class PasswordChangePresenter: PasswordChangeViewOutput, PasswordChangePresenterOutput {

    private weak var view: PasswordChangeViewInput?
    
    var onSuccess: (() -> Void)?
    
    init(view: PasswordChangeViewInput) {
        self.view = view
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
        Auth.auth().currentUser?.updatePassword(to: newPassword) { [weak self] error in
            guard error == nil else {
                if let error = error,
                   let errCode = AuthErrorCode(rawValue: error._code) {
                    self?.view?.displayAlert(errCode.errorMessage)
                }
                return
            }
            do {
                try Auth.auth().signOut()
            } catch  let signOutError as NSError {
                self?.view?.displayAlert("Error signing out: \(signOutError.debugDescription)")
            }
            Session.uid = nil
            self?.onSuccess?()
        }
    }
}
