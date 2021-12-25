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
    func makeLoginView() -> LoginViewInput & Presentable {
        return LoginAssembly.build()
    }
    
    func makeSignUpView() -> Presentable & SignUpViewInput {
        return SignUpAssembly.build()
    }
}

// MARK: - Main Flow
extension ModulesFactory: MainModuleFactory {
    func makeHomeView() -> HomeViewInput & Presentable {
        return HomeAssembly.build()
    }
    
    func makeUserProfileView() -> Presentable & UserProfileViewInput {
        return UserProfileAssembly.build()
    }
    
    func makeUserProfileDetailView() -> Presentable & UserProfileDetailViewInput {
        return UserProfileDetailAssembly.build()
    }
    
    func makeLevelsView() -> LevelsViewInput & Presentable {
        return LevelsAssembly.build()
    }
}
