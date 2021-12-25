//
//  UserProfileDetailPresenter.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 20.12.2021.
//

import Foundation

final class UserProfileDetailPresenter: UserProfileDetailPresenterOutput, UserProfileDetailViewOutput {
    var userProfile: UserProfile?
    
    private weak var view: UserProfileDetailViewInput?
    
    init(view: UserProfileDetailViewInput) {
        self.view = view
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
        let profile = UserProfile(email: self.userProfile?.email,
                                  phone: phone,
                                  city: city,
                                  lastName: lastName,
                                  firstName: firstName,
                                  sex: SexType(rawValue: sex ?? ""),
                                  birthday: birthday?.toDate())
        do {
            try FirestoreManager.shared.saveUserProfile(profile: profile)
        } catch let error {
                print("Error update profile: \(error.localizedDescription)")
            return
        }
    }
    
    func viewDidLoad() {
        FirestoreManager.shared.readUserProfile {[weak self] (result) in
            switch result {
            case .success(let profile):
                if let profile = profile {
                    self?.userProfile = profile
                    self?.view?.displayUserProfile()
                }
            case .failure(let error):
                print("Error decoding profile: \(error.localizedDescription)")
            }
        }
    }
}
