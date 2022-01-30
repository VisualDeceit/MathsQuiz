//
//  ScoreContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 30.01.2022.
//

import Foundation

protocol ScoreViewInput: AnyObject {
    var presenter: (ScoreViewOutput & ScorePresenterOutput)? { get set }
}

protocol ScoreViewOutput: AnyObject {
    var activityType: ActivityType { get }
    var scoreViewType: ScoreViewType { get }
    
    func viewDidLoad()
    func closeButtonDidTapped()
}

protocol ScorePresenterOutput {
    var onClose: (() -> Void)? { get set }
}
