//
//  HomePresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 19.12.2021.
//

import Foundation

final class HomePresenter: HomePresenterOutput, HomeViewOutput {
    var activities: [Activity]?
    var onSelectActivity: ((ActivityType) -> Void)?
    var onAccountButtonTap: (() -> Void)?
    
    private weak var view: HomeViewInput?
    
    init(view: HomeViewInput) {
        self.view = view
    }
}

// MARK: - HomeViewOutput
extension HomePresenter {
    
    func viewDidSelectActivity(type: ActivityType) {
        onSelectActivity?(type)
    }
    
    func viewDidLoad() {
        activities = Stub.activities // stub
        FirestoreManager.shared.readUserProfile {[weak self] (result) in
            switch result {
            case .success(let profile):
                if let profile = profile {
                    if let name = profile.firstName {
                        self?.view?.setGreeting(message: "Привет, \(name)!")
                    } else {
                        self?.view?.setGreeting(message: "Привет, дружище!")
                    }
                } else {
                    print("Document does not exist")
                }
            case .failure(let error):
                print("Error decoding profile: \(error.localizedDescription)")
            }
        }
        view?.reloadCollection()
    }
    
    func viewDidAccountButtonTap() {
        onAccountButtonTap?()
    }
}
