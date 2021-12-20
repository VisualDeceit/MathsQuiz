//
//  UserDataPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 20.12.2021.
//

import Foundation

final class UserDataPresenter: UserDataPresenterOutput {
    private weak var view: UserDataViewInput?
    
    init(view: UserDataViewInput) {
        self.view = view
    }
}

// MARK: - UserDataViewOutput
extension UserDataPresenter: UserDataViewOutput {
    func viewDidSaveButtonTap() {
        print(#function)
    }    
}
