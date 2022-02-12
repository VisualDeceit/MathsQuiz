//
//  HomePresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 19.12.2021.
//

import Foundation

final class HomePresenter: HomePresenterOutput, HomeViewOutput {
    
    let firestoreManager: StorageManager
    
    var onSelectActivity: ((ActivityType) -> Void)?
    var onAccountButtonTap: (() -> Void)?
    var activities: [Activity]?
    
    private weak var view: HomeViewInput?
    
    init(view: HomeViewInput, firestoreManager: StorageManager) {
        self.view = view
        self.firestoreManager = firestoreManager
    }
}

// MARK: - HomeViewOutput
extension HomePresenter {
    
    func viewDidSelectItemAt(_ indexPath: IndexPath) {
        if let activity = activities?[indexPath.row],
           activity.type.totalLevels > 0 {
            onSelectActivity?(activity.type)
        }
    }
    
    func viewDidLoad() {
        
        firestoreManager.loadUserProfile(uid: Session.uid, completion: {[weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let profile):
                if let name = profile.firstName, !name.isEmpty {
                    self.view?.setGreeting(message: "Привет, \(name)!")
                } else {
                    self.view?.setGreeting(message: "Привет, дружище!")
                }
                
            case .failure(let error):
                print("Error decoding profile: \(error.localizedDescription)")
                self.view?.setGreeting(message: "Привет, дружище!")
            }
        })
        
        self.firestoreManager.loadActivities(uid: Session.uid, completion: {[weak self] (result) in
            guard let self = self else { return }
            
            var activityViewData = [ActivityViewData]()
            
            switch result {
            case .success(let activities):
                self.activities = activities
                let group = DispatchGroup()
                
                activities.forEach { activity in
                    group.enter()
                    self.firestoreManager.loadStatistics(uid: Session.uid,
                                                         activityType: activity.type,
                                                         completion: { (result) in
                        switch result {
                        case .success(let statistics):
                            activityViewData.append(self.parse(from: activity, with: statistics))
                            group.leave()
                        case .failure:
                            group.leave()
                        }
                    })
                }
                
                group.notify(queue: .main) {
                    self.view?.setActivities(activityViewData.sorted { $0.index < $1.index })
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func viewDidAccountButtonTap() {
        onAccountButtonTap?()
    }
    
    private func parse(from activity: Activity, with statistics: ActivityStatistics) -> ActivityViewData {
        let levelCountLabel: String
        let progress: Double
        
        switch activity.type.totalLevels {
        case 0:
            levelCountLabel = "Нет доступных"
        default:
            levelCountLabel = "\(activity.type.totalLevels) уровней"
        }
        
        if activity.type.totalLevels == 0 {
            progress = 0
        } else {
            progress = Double(statistics.completion) / Double(activity.type.totalLevels)
        }
        
        return .init(index: activity.index,
                     title: activity.type.rawValue,
                     color: activity.type.color,
                     totalLevels: levelCountLabel,
                     completed: "\(statistics.completion)",
                     progress: progress)
    }
}
