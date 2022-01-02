//
//  ExampleAssembly.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 02.01.2022.
//

import Foundation

final class ExampleAssembly {
    static func build(activity: ActivityType, level: Level) -> Presentable & ExampleViewInput {
        let view = ExampleViewController()
        let presenter = ExamplePresenter(view: view, activity: activity, level: level)
        view.presenter = presenter
        return view
    }
}
