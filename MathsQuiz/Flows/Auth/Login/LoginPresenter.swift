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
    
    var onCompleteAuth: CompletionBlock?
    var onSignUpButtonTap: CompletionBlock?
    var onPasswordReset: CompletionBlock?
    
    private weak var view: LoginViewInput?
    
    fileprivate var currentNonce: String?
    
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
            
            self?.signIn(with: credential)
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
                    self?.signIn(with: credential)
                }
            case .cancelled:
                break
            case .failed (let error):
                self?.view?.displayAlert(error.localizedDescription)
            }
        }
    }
    
    private func signIn(with credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
            if let error = error {
                self?.view?.displayAlert(error.localizedDescription)
                return
            }
            Session.uid = authResult?.user.uid
            FirestoreManager.shared.isUserProfileExist(uid: Session.uid) { [weak self] exist in
                if !exist {
                    let userProfile = UserProfile(email: authResult?.user.email,
                                                  phone: authResult?.user.phoneNumber,
                                                  city: nil,
                                                  lastName: nil,
                                                  firstName: authResult?.user.displayName,
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
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
                if let error = error {
                    // Error. If error.code == .MissingOrInvalidNonce, make sure
                    // you're sending the SHA256-hashed nonce as a hex string with
                    // your request to Apple.
                    self?.view?.displayAlert(error.localizedDescription)
                    return
                }
                
                Session.uid = authResult?.user.uid
                
                FirestoreManager.shared.isUserProfileExist(uid: Session.uid) { [weak self] exist in
                    if !exist {
                        let userProfile = UserProfile(email: authResult?.user.email,
                                                      phone: authResult?.user.phoneNumber,
                                                      city: nil,
                                                      lastName: nil,
                                                      firstName: authResult?.user.displayName,
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
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        view?.displayAlert("Sign in with Apple errored: \(error)")
    }
}
