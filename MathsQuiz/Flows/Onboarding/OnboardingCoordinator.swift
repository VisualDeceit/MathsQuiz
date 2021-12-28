//
//  OnboardingCoordinator.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 28.12.2021.
//

import Foundation

final class OnboardingCoordinator: BaseCoordinator {
    
    private let factory: OnboardingModuleFactory
    private let router: Router

    init(router: Router, factory: OnboardingModuleFactory) {
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        performOnboarding()
    }
    
    private func performOnboarding() {
        let view = factory.makeOnboardingView()
        view.presenter?.onFinish = { [weak self] in
            self?.finishFlow?()
        }
        router.setRootModule(view, hideBar: true)
    }
}
