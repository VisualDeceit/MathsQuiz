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
        let view = factory.makeHomeView()
        
        view.presenter?.onSelectActivity = { [weak self] activityType in
            self?.showLevels(for: activityType)
        }
        
        view.presenter?.onAccountButtonTap = { [weak self] in
            self?.showUserProfile()
        }
        
        router.setRootModule(view, hideBar: true)
    }
    
    private func showUserProfile() {
        let view = factory.makeUserProfileView()
        
        view.presenter?.onMyDataButtonTap = { [weak self] in
            self?.showUserProfileDetail()
        }
        
        view.presenter?.onPasswordChangeTap = { [weak self] in
            self?.showPasswordChange()
        }
        
        view.presenter?.onLogout = { [weak self] in
            self?.finishFlow?()
        }
        
        router.push(view, hideNavBar: false)
    }
    
    private func showPasswordChange() {
        let view = factory.makePasswordChangeView()
        
        view.presenter?.onSuccess = { [weak self] in
            self?.finishFlow?()
        }
        
        router.push(view, hideNavBar: false)
    }
    
    private func showUserProfileDetail() {
        let view = factory.makeUserProfileDetailView()
        router.push(view)
    }
    
    private func showLevels(for activity: ActivityType) {
        print(activity.rawValue)
        let view = factory.makeLevelsView()
        
        router.push(view, hideNavBar: false)
    }
}
