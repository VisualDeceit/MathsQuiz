//
//  CoordinatorFactory.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 17.12.2021.
//

import Foundation

protocol CoordinatorFactory {
    func makeAuthCoordinator(router: Router) -> Coordinator
    func makeMainCoordinator(router: Router) -> Coordinator
    func makeOnboardingCoordinator(router: Router) -> Coordinator
}
