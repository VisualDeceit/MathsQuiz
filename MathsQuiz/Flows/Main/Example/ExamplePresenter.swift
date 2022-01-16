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
    var timer: Timer?
    var timeInterval = 0
    
    weak var view: ExampleViewInput?
    
    init(view: ExampleViewInput, factory: ExampleFactory, level: Level) {
        self.view = view
        self.level = level
        self.factory = factory
        self.activity = factory.type
    }
    
    func viewDidLoad() {
        makeExample()
    }
    
    func viewDidSetDigit(value: Int, at index: Int) {
        let digit = Digit(value: value, carry: 0)
        userResult[index] = digit
    }
    
    func viewDidCheckButtonTap() {
        if userResult == factory.solution.result {
            print("Correct decision!")
            // todo: save level progress to db
            // todo: calculate score
            level.number += 1
            attempts = 3
            makeExample()
        } else {
            attempts -= 1
            if attempts < 0 {
                attempts = 0
            }
            view?.refreshAttemptsView(with: attempts)
            print("Incorrect decision :(")
        }
    }
    
    private func makeExample() {
        if let exampleView = factory.makeAdditionExample(for: level) {
            view?.displayExample(view: exampleView)
            view?.refreshAttemptsView(with: attempts)
            createTimer()
        }
    }
    
    private func createTimer() {
        if timer == nil {
            let timer = Timer(timeInterval: 1.0,
                              target: self,
                              selector: #selector(timerHandler),
                              userInfo: nil,
                              repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.1
            self.timer = timer
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        timeInterval = 0
    }
    
    @objc func timerHandler() {
        timeInterval += 1
        view?.refreshTimerView(with: timeFormatted(timeInterval))
    }
    
    private func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
