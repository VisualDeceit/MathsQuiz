//
//  CoordinatorFactoryImp.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 17.12.2021.
//

import Foundation

final class CoordinatorFactoryImp {
    fileprivate let modulesFactory = ModulesFactory()
}

// MARK: - CoordinatorFactoryProtocol
extension CoordinatorFactoryImp: CoordinatorFactory {
    
    func makeAuthCoordinator(router: Router) -> Coordinator {
        return  AuthCoordinator(router: router, factory: modulesFactory)
    }
    
    func makeMainCoordinator(router: Router) -> Coordinator {
        return MainCoordinator(router: router, factory: modulesFactory)
    }
    
    func makeOnboardingCoordinator(router: Router) -> Coordinator {
        return OnboardingCoordinator(router: router, factory: modulesFactory)
    }
}
