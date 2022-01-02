//
//  OnboardingPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 28.12.2021.
//

import Foundation

final class OnboardingPresenter: OnboardingViewOutput, OnboardingPresenterOutput {
    
    var onFinish: (() -> Void)?
    weak var view: OnboardingViewInput?
    
    init(view: OnboardingViewInput) {
        self.view = view
    }
    
    func viewDidBeginButtonTap() {
        onFinish?()
    }
}
