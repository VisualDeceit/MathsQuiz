//
//  ExamplePresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 02.01.2022.
//

import Foundation

final class ExamplePresenter: ExampleViewOutput, ExamplePresenterOutput {

    let factory: ExampleFactory
    let activity: ActivityType
    
    var level: Level
    var userResult = [Int: Digit]()
    var attempts = 3
    
    weak var view: ExampleViewInput?
    
    init(view: ExampleViewInput, factory: ExampleFactory, level: Level) {
        self.view = view
        self.level = level
        self.factory = factory
        self.activity = factory.type
    }
    
    func viewDidLoad() {
        if let exampleView = factory.makeAdditionExample(for: level) {
            view?.displayExample(view: exampleView)
            view?.refreshAttemptsView(with: attempts)
        }
    }
    
    func viewDidSetDigit(value: Int, at index: Int) {
        let digit = Digit(value: value, carry: 0)
        userResult[index] = digit
    }
    
    func viewDidCheckButtonTap() {
        if userResult == factory.solution.result {
            print("Correct decision!")
        } else {
            attempts -= 1
            if attempts < 0 {
                attempts = 0
            }
            view?.refreshAttemptsView(with: attempts)
            print("Incorrect decision :(")
        }
    }
}
