//
//  UserProfileDetailPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 20.12.2021.
//

import Foundation

final class UserProfileDetailPresenter: UserProfileDetailPresenterOutput, UserProfileDetailViewOutput {
    
    let firestoreManager: StorageManager
    
    var userProfile: UserProfile?
    
    private weak var view: UserProfileDetailViewInput?
    
    init(view: UserProfileDetailViewInput, firestoreManager: StorageManager) {
        self.view = view
        self.firestoreManager = firestoreManager
    }
}

// MARK: - UserProfileDetailViewOutput
extension UserProfileDetailPresenter {
    func viewDidSaveButtonTap(city: String?,
                              lastName: String?,
                              firstName: String?,
                              sex: String?,
                              birthday: String?,
                              phone: String?) {
        
        var birthdayDate: Date?
        if let birthday = birthday {
            birthdayDate = DateFormatter.shortLocalStyle.date(from: birthday)
        }
        
        let profile = UserProfile(email: self.userProfile?.email,
                                  phone: phone,
                                  city: city,
                                  lastName: lastName,
                                  firstName: firstName,
                                  sex: Sex(rawValue: sex ?? ""),
                                  birthday: birthdayDate)
        do {
            try firestoreManager.saveUserProfile(profile: profile)
        } catch let error {
                print("Error update profile: \(error.localizedDescription)")
            return
        }
    }
    
    func viewDidLoad() {
        firestoreManager.loadUserProfile {[weak self] (result) in
            switch result {
            case .success(let profile):
                self?.userProfile = profile
                self?.view?.displayUserProfile()
            case .failure(let error):
                print("Error decoding profile: \(error.localizedDescription)")
            }
        }
    }
}
