//
//  ExamplePresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 02.01.2022.
//

import Foundation

final class ExamplePresenter: ExampleViewOutput, ExamplePresenterOutput {

    weak var view: ExampleViewInput?
    
    var level: Level
    var activity: ActivityType
    
    init(view: ExampleViewInput, activity: ActivityType, level: Level) {
        self.view = view
        self.activity = activity
        self.level = level
    }
    
    func viewDidLoad() {
        print(level)
    }
}
