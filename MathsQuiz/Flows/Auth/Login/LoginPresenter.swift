//
//  LoginPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 14.12.2021.
//

import Foundation
import Firebase
import GoogleSignIn
import AuthenticationServices
import FBSDKLoginKit

class LoginPresenter: NSObject, LoginViewOutput, LoginPresenterOutput {
    
    let authService: AuthorizationService
    let firestoreManager: StorageManager
    
    var onCompleteAuth: (() -> Void)?
    var onSignUpButtonTap: (() -> Void)?
    var onPasswordReset: (() -> Void)?
    
    private weak var view: LoginViewInput?
    fileprivate var currentNonce: String?
    
    init(view: LoginViewInput,
         authService: AuthorizationService,
         firestoreManager: StorageManager) {
        self.view = view
        self.authService = authService
        self.firestoreManager = firestoreManager
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
            // Sign In with Apple can only be configured by members of the Apple Developer Program
            // performAppleSignInFlow()
            break
        case .facebook:
            performFacebookSignInFlow()
        case .emailPassword:
            if let credentials = credentials {
                performEmailPasswordLoginFlow(with: credentials)
            }
        }
    }
    
    private func performEmailPasswordLoginFlow(with credentials: Credentials) {
        authService.signIn(with: credentials) {[weak self] result in
            switch result {
            case .success(let loginResult):
                Session.uid = loginResult.user.uid
                self?.onCompleteAuth?()
            case .failure(let error):
                let errCode = AuthErrorCode(rawValue: error._code)
                self?.view?.displayAlert(errCode?.errorMessage)
            }
        }
    }
    
    private func performGoogleSignInFlow() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        guard let view = view as? UIViewController else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config,
                                        presenting: view) { [weak self] user, error in
            if let error = error {
                self?.view?.displayAlert(error)
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                self?.view?.displayAlert("Unexpected sign in result: required authentication data is missing")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            self?.loginFirebase(with: credential)
        }
    }
    
    private func  performAppleSignInFlow() {
        let nonce = Nonce.randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = Nonce.sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = view as? ASAuthorizationControllerPresentationContextProviding
        authorizationController.performRequests()
    }
    
    private func performFacebookSignInFlow() {
        let loginManager = LoginManager()
        guard let configuration = LoginConfiguration(
            permissions: ["email", "public_profile"],
            tracking: .enabled,
            messengerPageId: nil,
            authType: nil
        )
        else {
            return
        }
        
        loginManager.logIn(configuration: configuration) { [weak self] (result) in
            switch result {
            case .success(_, _, token: let token):
                if let token = token {
                    let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
                    self?.loginFirebase(with: credential)
                }
            case .cancelled:
                break
            case .failed (let error):
                self?.view?.displayAlert(error)
            }
        }
    }
    
    private func loginFirebase(with credential: AuthCredential) {
        authService.signIn(with: credential) {  [weak self] result in
            switch result {
            case .success(let loginResult):
                Session.uid = loginResult.user.uid
                self?.firestoreManager.isUserProfileExist(uid: Session.uid) { [weak self] exist in
                    if !exist {
                        let userProfile = UserProfile(email: loginResult.user.email,
                                                      phone: loginResult.user.phoneNumber,
                                                      city: nil,
                                                      lastName: nil,
                                                      firstName: loginResult.user.displayName,
                                                      sex: nil,
                                                      birthday: nil)
                        do {
                            try self?.firestoreManager.saveUserProfile(uid: Session.uid,
                                                                       profile: userProfile)
                        } catch let error {
                            self?.authService.deleteCurrentUser { _ in }
                            Session.uid = nil
                            self?.view?.displayAlert(error)
                            return
                        }
                    }
                }
                self?.onCompleteAuth?()
            case .failure(let error):
                let errCode = AuthErrorCode(rawValue: error._code)
                self?.view?.displayAlert(errCode?.errorMessage)
            }
        }
    }
}

// MARK: - ASAuthorizationControllerDelegate
extension LoginPresenter: ASAuthorizationControllerDelegate {
    func authorizationController (controller: ASAuthorizationController,
                                  didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            loginFirebase(with: credential)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        view?.displayAlert(error)
    }
}
