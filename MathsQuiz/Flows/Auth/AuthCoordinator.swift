//
//  AuthCoordinator.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 16.12.2021.
//

import Foundation

final class AuthCoordinator: BaseCoordinator, AuthCoordinatorOutput {
    var finishFlow: (() -> Void)?
    
    private let factory: AuthModuleFactory
    private let router: Router

    init(router: Router, factory: AuthModuleFactory) {
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        showLogin()
    }
    
    //MARK: - Run current flow's controllers
    private func showLogin() {
        let view = factory.makeLoginModule()
        view.presenter?.onCompleteAuth = { [weak self] in
            self?.finishFlow?()
        }
        
        view.presenter?.onSignUpButtonTap = { [weak self] in
            self?.showSignUp()
        }
        router.setRootModule(view, hideBar: true)
    }
    
    private func showSignUp() {
        let view = factory.makeSignUpModule()
        view.presenter?.onSignUpComplete = { [weak self] in
            self?.router.popModule()
        }
        
        view.presenter?.onLoginButtonTap = { [weak self] in
            self?.router.popModule()
        }
        
        router.push(view, animated: true)
    }
    
    private func showTerms() {
        
    }
}

