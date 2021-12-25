//
//  UserAccountContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 20.12.2021.
//

import Foundation

protocol UserProfileViewInput: AnyObject {
    var presenter: (UserProfileViewOutput & UserProfilePresenterOutput)? { get set }
    func displayProfile(userName: String, email: String)
}

protocol UserProfileViewOutput: AnyObject {
    func viewDidChangePhotoButtonTap()
    func viewDidMyDataButtonTap()
    func viewDidChangePasswordButtonTap()
    func viewDidLogoutButtonTap()
    func viewDidLoad()
}

protocol UserProfilePresenterOutput: AnyObject {
    var onMyDataButtonTap: (() -> Void)? { get set }
    var onLogout: (() -> Void)? { get set }
}
