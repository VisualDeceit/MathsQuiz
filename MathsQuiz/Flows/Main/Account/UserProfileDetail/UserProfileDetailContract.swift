//
//  UserDataContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 20.12.2021.
//

import Foundation

protocol UserProfileDetailViewInput: AnyObject {
    var presenter: (UserProfileDetailViewOutput & UserProfileDetailPresenterOutput)? { get set }
    func displayUserProfile()
}

protocol UserProfileDetailViewOutput: AnyObject {
    var userProfile: UserProfile? { get set }
    func viewDidSaveButtonTap(city: String?,
                              lastName: String?,
                              firstName: String?,
                              sex: String?,
                              birthday: String?,
                              phone: String?)
    func viewDidLoad()
}

protocol UserProfileDetailPresenterOutput: AnyObject {
}
