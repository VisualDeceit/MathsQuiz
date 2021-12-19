//
//  HomePresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 19.12.2021.
//

import Foundation

final class HomePresenter: HomePresenterOutput {

    var onSelectActivity: ((ActivityType) -> Void)?
    var onAccoutButtonTap: (() -> Void)?
    
    private weak var view: HomeViewInput?
    private var model = [Activity]()
    
    init(view: HomeViewInput) {
        self.view = view
    }
}

// MARK: - HomeViewOutput
extension HomePresenter: HomeViewOutput {

    func viewDidSelectActivity(type: ActivityType) {
        onSelectActivity?(type)
    }
    
    func viewDidLoad() {
        let data = HomeCollectionViewData.data // stub
        view?.reloadCollection(with: data)
    }
    
    func viewDidAccountButtonTap() {
        onAccoutButtonTap?()
    }
}
