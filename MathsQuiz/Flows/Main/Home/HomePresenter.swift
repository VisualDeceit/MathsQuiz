//
//  HomePresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 19.12.2021.
//

import Foundation

final class HomePresenter: HomePresenterOutput, HomeViewOutput {
    var activities: [Activity]
    var onSelectActivity: ((ActivityType) -> Void)?
    var onAccoutButtonTap: (() -> Void)?
    
    private weak var view: HomeViewInput?
    
    init(view: HomeViewInput) {
        self.view = view
        activities = HomeCollectionViewData.data // stub
    }
}

// MARK: - HomeViewOutput
extension HomePresenter {
    
    func viewDidSelectActivity(type: ActivityType) {
        onSelectActivity?(type)
    }
    
    func viewDidLoad() {
        view?.reloadCollection()
    }
    
    func viewDidAccountButtonTap() {
        onAccoutButtonTap?()
    }
}
