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
    
    private weak var view: UserProfileViewInput?
    
    init(view: UserProfileViewInput) {
        self.view = view
    }
    
    private func logout() {
        do {
            try Auth.auth().signOut()
        } catch  let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        Session.uid = nil
        onLogout?()
    }
}

// MARK: - HomeViewOutput
extension UserProfilePresenter: UserProfileViewOutput {
    func viewDidLoad() {
        FirestoreManager.shared.readUserProfile {[weak self] (result) in
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
