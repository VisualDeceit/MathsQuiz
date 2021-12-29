//
//  LevelsContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 21.12.2021.
//

import Foundation

protocol LevelsViewInput: AnyObject {
    var presenter: (LevelsViewOutput & LevelsPresenterOutput)? { get set }
    var activity: ActivityType { get set }
    func reloadCollection()
}

protocol LevelsViewOutput: AnyObject {
    var levels: [Level]? { get set }
    func viewDidSelectLevel()
    func viewDidLoad()
}

protocol LevelsPresenterOutput: AnyObject {
}
