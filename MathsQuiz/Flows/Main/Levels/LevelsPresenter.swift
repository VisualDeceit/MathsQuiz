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
    func viewDidSelectLevel(_ level: Level) {
        onSelectLevel?(level)
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
                
                let levelsTail = [Level](repeating: Level.blocked, count: countToFill)
                self?.levels?.append(contentsOf: levelsTail)
                
                self?.view?.reloadCollection()
            case .failure(let error):
                print(error)
            }
        }
    }
}
