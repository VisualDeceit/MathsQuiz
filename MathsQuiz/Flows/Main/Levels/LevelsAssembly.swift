//
//  LevelsAssembly.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 21.12.2021.
//

import Foundation

final class LevelsAssembly {
    static func build(activity: ActivityType) -> LevelsViewInput & Presentable {
        let view = LevelsViewController(activity: activity)
        let presenter = LevelsPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
