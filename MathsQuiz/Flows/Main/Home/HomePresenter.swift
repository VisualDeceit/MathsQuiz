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
    
    var firestoreManager: StorageManager
    
    private weak var view: HomeViewInput?
    
    init(view: HomeViewInput, firestoreManager: StorageManager) {
        self.view = view
        self.firestoreManager = firestoreManager
    }
}

// MARK: - HomeViewOutput
extension HomePresenter {
    
    func viewDidSelectActivity(type: ActivityType) {
        onSelectActivity?(type)
    }
    
    func viewDidLoad() {
        firestoreManager.readUserProfile {[weak self] (result) in
            switch result {
            case .success(let profile):
                if let profile = profile {
                    if let name = profile.firstName {
                        self?.view?.setGreeting(message: "Привет, \(name)!")
                        self?.firestoreManager.loadUserProgress(completion: { (result) in
                            switch result {
                            case .success(let activities):
                                self?.activities = activities
                                self?.view?.reloadCollection()
                            case .failure(let error):
                                print(error)
                            }
                        })
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
    }
    
    func viewDidAccountButtonTap() {
        onAccountButtonTap?()
    }
}
