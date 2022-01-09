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
        
        let strategy = AdditionActivityStrategy()
        let resolver = ExampleResolver(type: activity)
        let factory = MainExampleFactory(strategy: strategy, resolver: resolver)
        
        let presenter = ExamplePresenter(view: view, factory: factory, level: level)
        view.presenter = presenter
        return view
    }
}
