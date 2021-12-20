//
//  UserAccountContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 20.12.2021.
//

import Foundation

protocol UserAccountViewInput: AnyObject {
    var presenter: (UserAccountViewOutput & UserAccountPresenterOutput)? { get set }
}

protocol UserAccountViewOutput: AnyObject {
    func viewDidChangePhotoButtonTap()
    func viewDidMyDataButtonTap()
    func viewDidChangePasswordButtonTap()
    func viewDidLogoutButtonTap()
}

protocol UserAccountPresenterOutput: AnyObject {
    var onMyDataButtonTap: (() -> Void)? { get set }
}
