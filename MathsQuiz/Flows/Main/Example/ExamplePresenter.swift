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
    var onFinish: ((ScoreViewType, Score) -> Void)?
    
    var score = Score()
    
    var isCorrect: Bool {
        userResult == factory.solution.result
    }
    
    var isGameOver: Bool {
        activity.totalLevels <= level.number
    }
    
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
    
    func viewDidCheckButtonTap(with behavior: CheckButtonBehavior) {
        switch behavior {
        case .check:
            if isCorrect {
                if isGameOver {
                    view?.changeCheckButton(behavior: .finish)
                } else {
                    view?.changeCheckButton(behavior: .transition)
                }
                view?.highlightSolution()
                
                level.attempts = attempts
                level.score = (attempts * level.number * 10) / timeInterval
                level.time = timeInterval
                
                score.value += level.score
                score.attempts += (3 - level.attempts)
                
                firestoreManager.saveLevel(uid: Session.uid,
                                           level: level,
                                           activityType: factory.type) { (error) in
                    print(error.localizedDescription)
                }
                
                stopTimer()
            } else {
                attempts -= 1
                if attempts <= 0 {
                    attempts = 0
                    score.attempts += 3
                    view?.changeCheckButton(behavior: .finish)
                    stopTimer()
                }
                view?.refreshAttemptsView(with: attempts)
            }
        case .transition:
                level.number += 1
                attempts = 3
                makeExample()
        case .finish:
            attempts == 0 ? onFinish?(.lose, score) : onFinish?(.win, score)
        }
    }
    
    func resetActivity() {
        level.number = 1
        attempts = 3
        makeExample()
    }
    
    private func makeExample() {
        let exampleView: NSObject?
        
        switch activity {
        case .addition:
            exampleView = factory.makeAdditionExample(for: level)
        case .subtraction:
            exampleView = factory.makeSubtractionExample(for: level)
        case .multiplication:
            exampleView = factory.makeMultiplicationExample(for: level)
        case .division:
            exampleView = nil
        case .expression:
            exampleView = nil
        }
        
        if let exampleView = exampleView {
            userResult.removeAll()
            factory.solution.result.forEach { key, _ in
                userResult[key] = Digit()
            }
            view?.displayExample(view: exampleView)
            let progressLabel = "\(level.number) из \(activity.totalLevels)"
            let progressPercent = Float(level.number) / Float(activity.totalLevels)
            view?.refreshProgress(label: progressLabel, percent: progressPercent)
            view?.refreshAttemptsView(with: attempts)
            view?.changeCheckButton(behavior: .check)
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
        timeInterval = 0
        view?.refreshTimerView(with: timeFormatted(timeInterval))
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
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
