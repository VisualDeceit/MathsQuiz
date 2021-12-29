//
//  LevelsPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 21.12.2021.
//

import Foundation

final class LevelsPresenter: LevelsPresenterOutput {
    private weak var view: LevelsViewInput?
    var levels: [Level]?
    var activity: ActivityType
    
    init(view: LevelsViewInput) {
        self.view = view
        self.activity = view.activity
    }
}

// MARK: - LevelsViewOutput
extension LevelsPresenter: LevelsViewOutput {
    func viewDidSelectLevel() {
        print(#function)
    }
    
    func viewDidLoad() {
        levels = Stub.levels // stub
    }
}
