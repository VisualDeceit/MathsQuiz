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
    
    required init(view: ScoreViewInput, firestoreManager: StorageManager) {
        self.view = view
        self.firestoreManager = firestoreManager
    }
    
    func viewDidLoad() {
    }
}
