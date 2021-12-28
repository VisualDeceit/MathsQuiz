//
//  OnboardingModuleFactory.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 28.12.2021.
//

import Foundation

protocol OnboardingModuleFactory {
    func makeOnboardingView() -> Presentable & OnboardingViewInput
}
