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

    var score: Score?
    
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
        firestoreManager.loadStatistics(activity: activityType) {[weak self] (result) in
            switch result {
            case .success(let statistics):
                let totalScore = "\(statistics.totalScore) очков"
                let totalTime = "\(self?.timeFormatted(statistics.time) ?? "") сек"
                let completion = "\(statistics.completion * 100 / (self?.activityType.totalLevels ?? 1))%"
                self?.view.displayStatistics(totalScore: totalScore,
                                             totalTime: totalTime,
                                             completion: completion)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func closeButtonDidTapped() {
        onClose?()
    }
    
    private func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
