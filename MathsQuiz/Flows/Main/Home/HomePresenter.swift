//
//  HomePresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 19.12.2021.
//

import Foundation

final class HomePresenter: HomePresenterOutput {
    
    var onSelectActivity: ((ActivityType) -> Void)?
    
    private weak var view: HomeViewInput?
    private var model = [Activity]()
    
    init(view: HomeViewInput) {
        self.view = view
    }
}

// MARK: - HomeViewOutput
extension HomePresenter: HomeViewOutput {
    func onDidSelectActivity(type: ActivityType) {
        onSelectActivity?(type)
    }
    
    func onViewDidLoad() {
        let data = HomeCollectionViewData.data // stub
        view?.reloadCollection(with: data)
    }
}
