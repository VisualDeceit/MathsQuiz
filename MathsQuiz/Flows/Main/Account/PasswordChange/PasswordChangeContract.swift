//
//  PasswordChangeContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 25.12.2021.
//

import Foundation

protocol PasswordChangeViewInput: AnyObject {
    var presenter: (PasswordChangeViewOutput & PasswordChangePresenterOutput)? { get set }
    func displayAlert(_ message: String?)
}

protocol PasswordChangeViewOutput {
    func viewDidChangePasswordButtonTap(_ passwordPair: PasswordPair)
}

protocol PasswordChangePresenterOutput {
    var onSuccess: (() -> Void)? { get set }
}
