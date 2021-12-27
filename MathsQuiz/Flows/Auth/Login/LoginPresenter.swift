//
//  LoginPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 14.12.2021.
//

import Foundation
import FirebaseAuth

class LoginPresenter: LoginViewOutput, LoginPresenterOutput {
    
    var onCompleteAuth: CompletionBlock?
    var onSignUpButtonTap: CompletionBlock?
    var onPasswordReset: CompletionBlock?
    
    private weak var view: LoginViewInput?
    
    required init(view: LoginViewInput) {
        self.view = view
    }
    
    func viewDidPasswordResetButtonTap() {
        onPasswordReset?()
    }
    
    func viewDidSignUpTap() {
        onSignUpButtonTap?()
    }

    func viewDidSignInButtonTap(provider: AuthProvider, credentials: Credentials? = nil) {
        switch provider {
        case .google:
            performGoogleSignInFlow()
        case .apple:
            performAppleSignInFlow()
        case .facebook:
            performFacebookSignInFlow()
        case .emailPassword:
            if let credentials = credentials {
                performEmailPasswordLoginFlow(with: credentials)
            }
        }
    }
    
    private func performEmailPasswordLoginFlow(with credentials: Credentials) {
        Auth.auth().signIn(withEmail: credentials.email, password: credentials.password) { [weak self] loginResult, error in
            guard let loginResult = loginResult, error == nil else {
                if let error = error,
                   let errCode = AuthErrorCode(rawValue: error._code) {
                    self?.view?.displayAlert(errCode.errorMessage)
                }
                return
            }
            Session.uid = loginResult.user.uid
            self?.onCompleteAuth?()
        }
    }
    
    private func performGoogleSignInFlow() {
    }
    
    private func  performAppleSignInFlow() {
    }
    
    private func performFacebookSignInFlow() {
    }
}
