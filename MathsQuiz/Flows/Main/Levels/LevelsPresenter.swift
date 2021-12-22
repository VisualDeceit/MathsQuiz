//
//  LevelsPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 21.12.2021.
//

import Foundation

final class LevelsPresenter: LevelsPresenterOutput {
    private weak var view: LevelsViewInput?
    
    init(view: LevelsViewInput) {
        self.view = view
    }
}

// MARK: - LevelsViewOutput
extension LevelsPresenter: LevelsViewOutput {
    func viewDidSelectLevel() {
        print(#function)
    }
}
