//
//  ScorePresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 30.01.2022.
//

import Foundation

final class ScorePresenter: ScoreViewOutput, ScorePresenterOutput {
    
    unowned var view: ScoreViewInput
    
    let firestoreManager: StorageManager
    let activityType: ActivityType
    let scoreViewType: ScoreViewType
    
    var onClose: (() -> Void)?
    
    required init(view: ScoreViewInput,
                  activityType: ActivityType,
                  scoreViewType: ScoreViewType,
                  firestoreManager: StorageManager) {
        self.view = view
        self.firestoreManager = firestoreManager
        self.activityType = activityType
        self.scoreViewType = scoreViewType
    }
    
    func viewDidLoad() {
    }
    
    func closeButtonDidTapped() {
        onClose?()
    }
}
