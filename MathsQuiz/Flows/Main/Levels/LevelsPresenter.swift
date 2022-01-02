//
//  LevelsPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 21.12.2021.
//

import Foundation

final class LevelsPresenter: LevelsPresenterOutput {
   
    var onSelectLevel: ((Level) -> Void)?
    
    var levels: [Level]?
    var activity: ActivityType
    
    private weak var view: LevelsViewInput?
    
    init(view: LevelsViewInput) {
        self.view = view
        self.activity = view.activity
    }
}

// MARK: - LevelsViewOutput
extension LevelsPresenter: LevelsViewOutput {
    func viewDidSelectLevel(_ level: Level) {
        onSelectLevel?(level)
    }
    
    func viewDidLoad() {
        levels = Stub.levels // stub
    }
}
