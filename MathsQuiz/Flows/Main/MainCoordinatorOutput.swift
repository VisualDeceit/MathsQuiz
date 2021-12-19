//
//  MainCoordinatorOutput.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 19.12.2021.
//

import Foundation

protocol MainCoordinatorOutput: AnyObject {
    var finishFlow: (() -> Void)? { get set }
}
