//
//  ModulesFactory.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 17.12.2021.
//

import UIKit

final class ModulesFactory {}

// MARK: - Auth Flow
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

// MARK: - Main Flow
extension ModulesFactory: MainModuleFactory {
    func makeHomeModule() -> HomeViewInput & Presentable {
        let view = HomeAssembly.build()
        return view
    }
    
    func makeUserAccountModule() -> Presentable & UserAccountViewInput {
        let view = UserAccountAssembly.build()
        return view
    }
    
    func makeUserDataModule() -> Presentable & UserDataViewInput {
        let view = UserDataAssembly.build()
        return view
    }
}
