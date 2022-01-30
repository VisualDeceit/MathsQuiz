//
//  ScoreAssembly.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 30.01.2022.
//

import Foundation

final class ScoreAssembly {
    static func build(activityType: ActivityType,
                      scoreViewType: ScoreViewType) -> Presentable & ScoreViewInput {
        let view = ScoreViewController()
        let presenter = ScorePresenter(view: view,
                                       activityType: activityType,
                                       scoreViewType: scoreViewType,
                                       firestoreManager: FirestoreManager())
        view.presenter = presenter
        return view
    }
}
