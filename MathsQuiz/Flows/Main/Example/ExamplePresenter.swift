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
    let firestoreManager: StorageManager
    
    var level: Level
    var userResult = [Int: Digit]()
    var attempts = 3
    var timer: Timer?
    var timeInterval = 0
    var onFinish: (() -> Void)?
    
    weak var view: ExampleViewInput?
    
    init(view: ExampleViewInput,
         factory: ExampleFactory,
         level: Level,
         firestoreManager: StorageManager) {
        self.view = view
        self.level = level
        self.factory = factory
        self.activity = factory.type
        self.firestoreManager = firestoreManager
    }
    
    func viewDidLoad() {
        makeExample()
    }
    
    func viewDidSetDigit(value: Int, at index: Int) {
        let digit = Digit(value: value, carry: 0)
        userResult[index] = digit
    }
    
    func viewDidCheckButtonTap(with title: CheckButtonTitle) {
        switch title {
        case .check:
            if userResult == factory.solution.result {
                view?.changeCheckButton(title: .transition)
                level.completion = attempts
                firestoreManager.saveLevel(level: level,
                                           for: factory.type) { (error) in
                    print(error.localizedDescription)
                }
                #warning("TODO: calculate score")
            } else {
                attempts -= 1
                if attempts < 0 {
                    attempts = 0
                }
                view?.refreshAttemptsView(with: attempts)
            }
        case .transition:
            if activity.totalLevels > level.number {
                level.number += 1
                attempts = 3
                makeExample()
            } else {
                onFinish?()
            }
        }
    }
    
    private func makeExample() {
        if let exampleView = factory.makeAdditionExample(for: level) {
            view?.displayExample(view: exampleView)
            let progressLabel = "\(level.number) из \(activity.totalLevels)"
            let progressPercent = Float(level.number) / Float(activity.totalLevels)
            view?.refreshProgress(label: progressLabel, percent: progressPercent)
            view?.refreshAttemptsView(with: attempts)
            view?.changeCheckButton(title: .check)
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
