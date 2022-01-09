//
//  Coordinator.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 16.12.2021.
//

import Foundation

protocol Coordinator: AnyObject {
    var finishFlow: (() -> Void)? { get set }
    func start()
}
