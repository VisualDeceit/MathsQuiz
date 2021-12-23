//
//  MainCoordinator.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 19.12.2021.
//

import Foundation

final class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {
    
    var finishFlow: (() -> Void)?
    
    private let factory: MainModuleFactory
    private let router: Router

    init(router: Router, factory: MainModuleFactory) {
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        showMain()
    }
    
    private func showMain() {
        let view = factory.makeHomeModule()
        view.presenter?.onSelectActivity = { [weak self] activityType in
            self?.showLevels(for: activityType)
        }
        view.presenter?.onAccountButtonTap = { [weak self] in
            self?.showAccount()
        }
        router.setRootModule(view, hideBar: true)
    }
    
    private func showAccount() {
        let view = factory.makeUserAccountModule()
        view.presenter?.onMyDataButtonTap = { [weak self] in
            self?.showUserData()
        }
        view.presenter?.onLogout = { [weak self] in
            self?.finishFlow?()
        }
        router.push(view, hideNavBar: false)
    }
    
    private func showUserData() {
        let view = factory.makeUserDataModule()
        router.push(view)
    }
    
    private func showLevels(for activity: ActivityType) {
        print(activity.rawValue)
        let view = factory.makeLevelsMoodule()
        router.push(view, hideNavBar: false)
    }
}
