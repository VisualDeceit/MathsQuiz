//
//  AuthCoordinator.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 16.12.2021.
//

import Foundation

final class AuthCoordinator: BaseCoordinator {
    
    private let factory: AuthModuleFactory
    private let router: Router

    init(router: Router, factory: AuthModuleFactory) {
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        showLogin()
    }
    
// MARK: - Run current flow's controllers
    private func showLogin() {
        let view = factory.makeLoginView()
        
        view.presenter?.onCompleteAuth = { [weak self] in
            self?.finishFlow?()
        }
        
        view.presenter?.onSignUpButtonTap = { [weak self] in
            self?.showSignUp()
        }
        
        view.presenter?.onPasswordReset = { [weak self] in
            self?.showPasswordReset()
        }
        
        router.setRootModule(view, hideBar: true)
    }
    
    private func showSignUp() {
        let view = factory.makeSignUpView()
        
        view.presenter?.onSignUpComplete = { [weak self] in
            self?.finishFlow?()
        }
        
        view.presenter?.onLoginButtonTap = { [weak self] in
            self?.router.popModule()
        }
        
        router.push(view, animated: true)
    }
    
    private func showPasswordReset() {
        let view = factory.makePasswordResetView()
        
        view.presenter?.onSuccessSend = { [weak router] in
            router?.dismissModule(animated: true, completion: nil)
        }
        
        router.present(view, animated: true)
    }
}
