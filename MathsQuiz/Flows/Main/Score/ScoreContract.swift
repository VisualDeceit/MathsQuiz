//
//  ScoreContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 30.01.2022.
//

import Foundation

protocol ScoreViewInput: AnyObject {
    var presenter: (ScoreViewOutput & ScorePresenterOutput)? { get set }
    
    func displayStatistics(totalScore: String, totalTime: String, completion: String)    
}

protocol ScoreViewOutput: AnyObject {
    var activityType: ActivityType { get }
    var scoreViewType: ScoreViewType { get }
    var score: Score? { get set }
    
    func viewDidLoad()
    func closeButtonDidTapped()
    func resetButtonDidTapped()
    func homeButtonDidTapped()
    func sharedObjectsPrepared(objects: [Any])
    func viewDidDismiss()
}

protocol ScorePresenterOutput {
    var onCloseProgrammatically: ((Bool) -> Void)? { get set }
    var onResetButtonTap: (() -> Void)? { get set }
    var onHomeButtonTap: (() -> Void)? { get set }
    var onShowShareActivity: (([Any]) -> Void)? { get set }
}
