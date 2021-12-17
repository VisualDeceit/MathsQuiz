//
//  AuthCoordinatorOutput.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 16.12.2021.
//

import Foundation

protocol AuthCoordinatorOutput: AnyObject {
    var finishFlow: (() -> Void)? { get set }
}
