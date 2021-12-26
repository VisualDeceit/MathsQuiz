//
//  PasswordResetContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 26.12.2021.
//

import Foundation

protocol PasswordResetViewInput: AnyObject {
    var presenter: (PasswordResetViewOutput & PasswordResetPresenterOutput)? { get set }
    func displayAlert(_ message: String)
}

protocol PasswordResetViewOutput: AnyObject {
    func viewDidSendButtonTap(_ email: String?)
    func viewDidCloseButtonTap()
}

protocol PasswordResetPresenterOutput: AnyObject {
    var onSuccessSend: CompletionBlock? { get set }
}
