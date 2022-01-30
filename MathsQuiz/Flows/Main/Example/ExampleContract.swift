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
    func refreshAttemptsView(with attempts: Int)
    func refreshTimerView(with time: String)
    func changeCheckButton(title: CheckButtonTitle)
    func refreshProgress(label: String, percent: Float)
    func highlightSolution()
}

protocol ExampleViewOutput: AnyObject {
    var activity: ActivityType { get }
    
    func viewDidLoad()
    func viewDidSetDigit(value: Int, at index: Int)
    func viewDidCheckButtonTap(with title: CheckButtonTitle)
}

protocol ExamplePresenterOutput {
    var onFinish: ((ScoreViewType) -> Void)? { get set }
}
