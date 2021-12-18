//
//  AppCoordinator.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 16.12.2021.
//

import UIKit

enum LaunchInstructor {
    case main, auth, onboarding
    
    static func configure() -> LaunchInstructor {
        
        switch (Session.isSeenOnboarding, Session.isAuthorized) {
        case (true, false), (false, false): return .auth
        case (false, true): return .onboarding
        case (true, true): return .main
        }
    }
}

final class AppCoordinator: BaseCoordinator {
    
    private let coordinatorFactory: CoordinatorFactoryImp
    private let router: Router
    
    private var instructor: LaunchInstructor {
        return LaunchInstructor.configure()
    }
    
    init(router: Router, coordinatorFactory: CoordinatorFactoryImp) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        runAuthFlow() // temp
//        switch instructor {
//        case .onboarding: runOnboardingFlow()
//        case .auth: runAuthFlow()
//        case .main: runMainFlow()
//        }
    }
    
    private func runAuthFlow() {
        let coordinator = coordinatorFactory.makeAuthCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            print("finishFlow")
//            isAutorized = true
            self?.start()
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runOnboardingFlow() {
        //        let coordinator = coordinatorFactory.makeOnboardingCoordinator(router: router)
        //        coordinator.finishFlow = { [weak self, weak coordinator] in
        //            onboardingWasShown = true
        //            self?.start()
        //            self?.removeDependency(coordinator)
        //        }
        //        addDependency(coordinator)
        //        coordinator.start()
    }
    
    private func runMainFlow() {
        //        let (coordinator, module) = coordinatorFactory.makeTabbarCoordinator()
        //        addDependency(coordinator)
        //        router.setRootModule(module, hideBar: true)
        //        coordinator.start()
    }
}
