//
//  MainCoordinator.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 19.12.2021.
//

import Foundation

final class MainCoordinator: BaseCoordinator {
    
    private let factory: MainModuleFactory
    private let router: Router
    
    var onResetActivity: (() -> Void )?
    var onCloseScoreView: (() -> Void )?

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
    
    private func showLevels(for activity: ActivityType) {
        let view = factory.makeLevelsView(activity: activity)
        
        view.presenter?.onSelectLevel = { [weak self] level in
            self?.showExample(for: activity, level: level)
        }
        
        router.push(view, hideNavBar: false)
    }
    
    private func showExample(for activity: ActivityType, level: Level) {
        let view = factory.makeExampleView(activity: activity, level: level)
        
        view.presenter?.onFinish = { [weak self] type, score in
            self?.showScore(for: activity, scoreViewType: type, score: score)
        }
        
        self.onResetActivity = { [weak view] in
            view?.presenter?.resetActivity()
        }
        
        self.onCloseScoreView = { [weak router] in
            router?.popModule(animated: true)
        }
        
        router.push(view)
    }
    
    private func showScore(for activityType: ActivityType, scoreViewType: ScoreViewType, score: Score) {
        let view = factory.makeScoreView(activityType: activityType,
                                         scoreViewType: scoreViewType,
                                         score: score)
        
        view.presenter?.onCloseProgrammatically = {[weak router, weak self] flag in
            if flag {
                router?.dismissModule(animated: true, completion: nil)
            }
            self?.onCloseScoreView?()
        }
        
        view.presenter?.onResetButtonTap = { [weak router, weak self] in
            router?.dismissModule(animated: true, completion: nil)
            self?.onResetActivity?()
        }
        
        view.presenter?.onHomeButtonTap = { [weak router] in
            router?.dismissModule(animated: true, completion: nil)
            router?.popToRootModule(animated: true)
        }
        
        view.presenter?.onShowShareActivity = {[weak router] sharedObjects in
            router?.presentShareActivity(sharedObjects: sharedObjects)
        }
        
        router.present(view, animated: true)
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
}
