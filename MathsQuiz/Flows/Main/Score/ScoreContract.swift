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
    func viewDidLoad()
}

protocol ScorePresenterOutput {
}
