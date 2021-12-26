//
//  PasswordResetPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 26.12.2021.
//

import Foundation
import FirebaseAuth

final class PasswordResetPresenter: PasswordResetViewOutput, PasswordResetPresenterOutput {

    var onSuccessSend: CompletionBlock?
    
    private weak var view: PasswordResetViewInput?
    
    init(view: PasswordResetViewInput) {
        self.view = view
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
        Auth.auth().sendPasswordReset(withEmail: email) {[weak self] error in
            guard error == nil else {
                if let error = error,
                   let errCode = AuthErrorCode(rawValue: error._code) {
                    self?.view?.displayAlert(errCode.errorMessage)
                }
                return
            }
            self?.onSuccessSend?()
        }
    }
}
