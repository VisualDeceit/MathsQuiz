//
//  CoordinatorFactory.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 17.12.2021.
//

import Foundation

protocol CoordinatorFactory {
    func makeAuthCoordinator(router: Router) -> Coordinator & AuthCoordinatorOutput
    func makeMainCoordinator(router: Router) -> Coordinator & MainCoordinatorOutput
}
