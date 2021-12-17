//
//  ModulesFactory.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 17.12.2021.
//

import UIKit

final class ModulesFactory {}

extension ModulesFactory: AuthModuleFactory {
    func makeLoginModule() -> LoginViewInput & Presentable {
        let view = LoginAssembly.build()
        return view
    }
    
    func makeSignUpModule() -> Presentable & SignUpViewInput {
        let view = SignUpAssembly.build()
        return view
    }
}
