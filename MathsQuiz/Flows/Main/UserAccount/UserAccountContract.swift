//
//  UserAccountContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 20.12.2021.
//

import Foundation

protocol UserAccountViewInput: AnyObject {
    var presenter: (UserAccountViewOutput & UserAccountPresenterOutput)? { get set }
    func updateProfile(name: String, email: String)
}

protocol UserAccountViewOutput: AnyObject {
    func viewDidChangePhotoButtonTap()
    func viewDidMyDataButtonTap()
    func viewDidChangePasswordButtonTap()
    func viewDidLogoutButtonTap()
    func viewDidLoad()
}

protocol UserAccountPresenterOutput: AnyObject {
    var onMyDataButtonTap: (() -> Void)? { get set }
    var onLogout: (() -> Void)? { get set }
}
