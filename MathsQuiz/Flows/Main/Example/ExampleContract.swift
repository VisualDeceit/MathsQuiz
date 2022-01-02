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
    var activity: ActivityType { get set }
    
    func viewDidLoad()
}

protocol ExamplePresenterOutput {
}
