//
//  LevelsContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 21.12.2021.
//

import Foundation

protocol LevelsViewInput: AnyObject {
    var presenter: (LevelsViewOutput & LevelsPresenterOutput)? { get set }
    
    func reloadCollection()
}

protocol LevelsViewOutput: AnyObject {
    var levels: [Level]? { get set }
    var activity: ActivityType { get set }
    
    func viewDidSelectLevel(_ level: Level)
    func viewDidLoad()
}

protocol LevelsPresenterOutput: AnyObject {
    var onSelectLevel: ((Level) -> Void)? { get set }
}
