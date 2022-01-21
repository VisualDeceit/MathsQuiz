//
//  PasswordResetContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 26.12.2021.
//

import Foundation

protocol PasswordResetViewInput: AnyObject, Alertable {
    var presenter: (PasswordResetViewOutput & PasswordResetPresenterOutput)? { get set }
}

protocol PasswordResetViewOutput: AnyObject {
    func viewDidSendButtonTap(_ email: String?)
    func viewDidCloseButtonTap()
}

protocol PasswordResetPresenterOutput: AnyObject {
    var onSuccessSend: (() -> Void)? { get set }
}
