//
//  ExampleContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 02.01.2022.
//

import UIKit

protocol ExampleViewInput: AnyObject {
    var presenter: (ExampleViewOutput & ExamplePresenterOutput)? { get set }
    
    func displayExample(view: UIView)
}

protocol ExampleViewOutput: AnyObject {
    var activity: ActivityType { get }
    
    func viewDidLoad()
}

protocol ExamplePresenterOutput {
}
