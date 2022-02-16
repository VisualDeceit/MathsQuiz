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
    
    var onCloseProgrammatically: ((Bool) -> Void)?
    var onResetButtonTap: (() -> Void)?
    var onHomeButtonTap: (() -> Void)?
    var onShowShareActivity: (([Any]) -> Void)?
    
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
        firestoreManager.loadStatistics(uid: Session.uid, activityType: activityType) {[weak self] (result) in
            switch result {
            case .success(let statistics):
                let totalScore = String(format: NSLocalizedString("statistic points", comment: ""),
                                        statistics.totalScore)
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
        onCloseProgrammatically?(true)
    }
    
    func viewDidDismiss() {
        onCloseProgrammatically?(false)
    }
    
    func resetButtonDidTapped() {
        onResetButtonTap?()
    }
    
    func homeButtonDidTapped() {
        onHomeButtonTap?()
    }
    
    func sharedObjectsPrepared(objects: [Any]) {
        onShowShareActivity?(objects)
    }
    
    private func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
