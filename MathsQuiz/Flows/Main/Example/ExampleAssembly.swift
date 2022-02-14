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
        
        let strategy: ActivityStrategy
        switch activity {
        case .addition:
            strategy = AdditionActivityStrategy()
        case .subtraction:
            strategy = SubtractionActivityStrategy()
        case .multiplication:
            strategy = AdditionActivityStrategy()
        case .division:
            strategy = AdditionActivityStrategy()
        case .expression:
            strategy = AdditionActivityStrategy()
        }
        
        let resolver = ExampleResolver(type: activity)
        let factory = MainExampleFactory(strategy: strategy, resolver: resolver)
        
        let presenter = ExamplePresenter(view: view,
                                         factory: factory,
                                         level: level,
                                         firestoreManager: FirestoreManager())
        view.presenter = presenter
        return view
    }
}
