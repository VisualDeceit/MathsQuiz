//
//  LoginPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 14.12.2021.
//

import Foundation
import Firebase
import GoogleSignIn

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
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        guard let view = view as? UIViewController else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config,
                                        presenting: view) { [weak self] user, error in
            
            guard error == nil else {
                if let error = error {
                    self?.view?.displayAlert(error.localizedDescription)
                }
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                let error = NSError(
                    domain: "GIDSignInError",
                    code: -1,
                    userInfo: [
                        NSLocalizedDescriptionKey: "Unexpected sign in result: required authentication data is missing."
                    ]
                )
                self?.view?.displayAlert(error.localizedDescription)
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { [weak self] loginResult, error in
                guard let loginResult = loginResult, error == nil else {
                    if let error = error,
                       let errCode = AuthErrorCode(rawValue: error._code) {
                        self?.view?.displayAlert(errCode.errorMessage)
                    }
                    return
                }
                
                Session.uid = loginResult.user.uid
                
                FirestoreManager.shared.isUserProfileExist(uid: Session.uid) { exist in
                    if !exist {
                        let userProfile = UserProfile(email: user?.profile?.email,
                                                      phone: loginResult.user.phoneNumber,
                                                      city: nil,
                                                      lastName: user?.profile?.familyName,
                                                      firstName: user?.profile?.givenName,
                                                      sex: nil,
                                                      birthday: nil)
                        do {
                            try FirestoreManager.shared.saveUserProfile(profile: userProfile)
                        } catch let error {
                            let user = Auth.auth().currentUser
                            user?.delete()
                            Session.uid = nil
                            self?.view?.displayAlert(error.localizedDescription)
                            return
                        }
                    }
                    self?.onCompleteAuth?()
                }
            }
        }
    }
    
    private func  performAppleSignInFlow() {
    }
    
    private func performFacebookSignInFlow() {
    }
}
