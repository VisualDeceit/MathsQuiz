//
//  UserAccountPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 20.12.2021.
//

import Foundation
import FirebaseAuth

final class UserProfilePresenter: UserProfilePresenterOutput {
    var onLogout: (() -> Void)?
    var onMyDataButtonTap: (() -> Void)?
    var onPasswordChangeTap: (() -> Void)?
    
    var authService: AuthorizationService
    var firestoreManager: StorageManager
    
    private weak var view: UserProfileViewInput?
    
    init(view: UserProfileViewInput,
         authService: AuthorizationService,
         firestoreManager: StorageManager) {
        self.view = view
        self.authService = authService
        self.firestoreManager = firestoreManager
    }
    
    private func logout() {
        authService.signOut {[weak self] error in
            if let error = error {
                self?.view?.displayAlert(error.localizedDescription)
            }
        }
        Session.uid = nil
        onLogout?()
    }
}

// MARK: - HomeViewOutput
extension UserProfilePresenter: UserProfileViewOutput {
    func viewDidLoad() {
        firestoreManager.readUserProfile {[weak self] (result) in
            switch result {
            case .success(let profile):
                var userName = ""
                if let firstName = profile?.firstName {
                    userName = "\(firstName) "
                }
                if let lastName = profile?.lastName {
                    userName.append(lastName)
                }
                self?.view?.displayProfile(userName: userName, email: profile?.email ?? "")
            case .failure(let error):
                print("Error decoding profile: \(error.localizedDescription)")
            }
        }
    }
    
    func viewDidChangePhotoButtonTap() {
        print(#function)
    }
    
    func viewDidMyDataButtonTap() {
        onMyDataButtonTap?()
    }
    
    func viewDidPasswordChangeButtonTap() {
        onPasswordChangeTap?()
    }
    
    func viewDidLogoutButtonTap() {
        logout()
    }
}
