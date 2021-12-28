//
//  OnboardingAssembly.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 28.12.2021.
//

import Foundation

final class OnboardingAssembly {
    static func build() -> Presentable & OnboardingViewInput {
        let view = OnboardingViewController(transitionStyle: .scroll)
        let presenter = OnboardingPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
