//
//  AuthModuleFactory.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 17.12.2021.
//

import UIKit

protocol AuthModuleFactory {
    func makeLoginModule() -> LoginViewInput & Presentable
}
