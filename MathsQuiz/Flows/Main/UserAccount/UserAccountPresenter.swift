//
//  UserAccountPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 20.12.2021.
//

import Foundation
import FirebaseAuth

final class UserAccountPresenter: UserAccountPresenterOutput {
    var onLogout: (() -> Void)?
    var onMyDataButtonTap: (() -> Void)?
    
    private weak var view: UserAccountViewInput?
    
    init(view: UserAccountViewInput) {
        self.view = view
    }
    
    private func logout() {
        do {
            try Auth.auth().signOut()
        } catch  let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        UserDefaultsWrapper.uid = nil
        onLogout?()
    }
}

// MARK: - HomeViewOutput
extension UserAccountPresenter: UserAccountViewOutput {
    func viewDidChangePhotoButtonTap() {
        print(#function)
    }
    
    func viewDidMyDataButtonTap() {
        onMyDataButtonTap?()
    }
    
    func viewDidChangePasswordButtonTap() {
        print(#function)
    }
    
    func viewDidLogoutButtonTap() {
        logout()
    }
}
