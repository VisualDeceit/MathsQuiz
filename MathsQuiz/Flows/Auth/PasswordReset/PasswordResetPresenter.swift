//
//  PasswordResetPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 26.12.2021.
//

import Foundation
import FirebaseAuth

final class PasswordResetPresenter: PasswordResetViewOutput, PasswordResetPresenterOutput {

    var onSuccessSend: (() -> Void)?
    
    var authService: AuthorizationService
    
    private weak var view: PasswordResetViewInput?
    
    init(view: PasswordResetViewInput, authService: AuthorizationService) {
        self.view = view
        self.authService = authService
    }
    
    func viewDidSendButtonTap(_ email: String?) {
        guard let email = email,
              !email.isEmpty else {
            view?.displayAlert("Пожалуйста, введите действующий адрес электронной почты")
            return
        }
        sendPasswordReset(email: email)
    }
    
    func viewDidCloseButtonTap() {
        onSuccessSend?()
    }
    
    private func sendPasswordReset(email: String) {
        authService.sendPasswordReset(to: email) {[weak self] error in
            if let error = error {
                let errCode = AuthErrorCode(rawValue: error._code)
                self?.view?.displayAlert(errCode?.errorMessage)
                return
            }
            self?.onSuccessSend?()
        }
    }
}
