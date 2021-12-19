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
        view.presenter?.onSelectActivity = { activityType in
            print(activityType.rawValue)
        }
        router.setRootModule(view, hideBar: true)
    }
}
