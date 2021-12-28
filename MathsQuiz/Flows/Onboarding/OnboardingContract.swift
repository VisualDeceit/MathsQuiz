//
//  OnboardingContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 28.12.2021.
//

import Foundation

protocol OnboardingViewInput: AnyObject {
    var presenter: (OnboardingViewOutput & OnboardingPresenterOutput)? { get set }
}

protocol OnboardingViewOutput: AnyObject {
    func viewDidBeginButtonTap()
}

protocol OnboardingPresenterOutput: AnyObject {
    var onFinish: CompletionBlock? { get set }
}
