//
//  LevelsContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 21.12.2021.
//

import Foundation

protocol LevelsViewInput: AnyObject {
    var presenter: (LevelsViewOutput & LevelsPresenterOutput)? { get set }
}

protocol LevelsViewOutput: AnyObject {
    func viewDidSelectLevel()
}

protocol LevelsPresenterOutput: AnyObject {
}
