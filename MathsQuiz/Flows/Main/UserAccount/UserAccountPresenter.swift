//
//  UserAccountPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 20.12.2021.
//

import Foundation

final class UserAccountPresenter: UserAccountPresenterOutput {
    var onMyDataButtonTap: (() -> Void)?
    
    private weak var view: UserAccountViewInput?
    
    init(view: UserAccountViewInput) {
        self.view = view
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
        print(#function)
    }
}
