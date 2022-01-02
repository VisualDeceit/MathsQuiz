//
//  ExampleContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 02.01.2022.
//

import Foundation

protocol ExampleViewInput: AnyObject {
    var presenter: (ExampleViewOutput & ExamplePresenterOutput)? { get set }
}

protocol ExampleViewOutput: AnyObject {
    func viewDidLoad()
}

protocol ExamplePresenterOutput {
}
