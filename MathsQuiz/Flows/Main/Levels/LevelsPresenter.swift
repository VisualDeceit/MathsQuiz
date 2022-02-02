//
//  LevelsPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 21.12.2021.
//

import Foundation

final class LevelsPresenter: LevelsPresenterOutput {
    
    let activity: ActivityType
    let firestoreManager: StorageManager
    
    var onSelectLevel: ((Level) -> Void)?
    var levels: [Level]?
   
    private weak var view: LevelsViewInput?
    
    init(view: LevelsViewInput, activity: ActivityType, firestoreManager: StorageManager) {
        self.view = view
        self.activity = activity
        self.firestoreManager = firestoreManager
    }
}

// MARK: - LevelsViewOutput
extension LevelsPresenter: LevelsViewOutput {
    func viewDidSelectItemAt(_ indexPath: IndexPath) {
        if let level = levels?[indexPath.row],
           level.attempts >= 0 {
            onSelectLevel?(level)
        }
    }
    
    func viewDidLoad() {
        firestoreManager.loadLevels(for: activity) {[weak self] (result) in
            switch result {
            case .success(let items):
                self?.levels = items
        
                var countToFill = (self?.activity.totalLevels ?? 0) - (self?.levels?.count ?? 0)
                if countToFill < 0 {
                    countToFill = 0
                }
                let blocked = Level(number: 0, attempts: -1, score: 0, time: 0)
                let levelsTail = [Level](repeating: blocked, count: countToFill)
                self?.levels?.append(contentsOf: levelsTail)
                
                self?.view?.reloadCollection()
            case .failure(let error):
                print(error)
            }
        }
    }
}
