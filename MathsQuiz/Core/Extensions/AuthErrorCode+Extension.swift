//
//  AuthErrorCode+Extension.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 18.12.2021.
//

import Foundation
import Firebase

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "Электронная почта уже используется с другой учетной записью"
        case .userNotFound:
            return "Аккаунт не найден для указанного пользователя. Пожалуйста, проверьте и попробуйте еще раз"
        case .userDisabled:
            return "Ваш аккаунт отключен. Обратитесь в службу поддержки"
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Пожалуйста, введите действующий адрес электронной почты"
        case .networkError:
            return "Ошибка сети. Повторите попытку"
        case .weakPassword:
            return "Ваш пароль слишком простой. Пароль должен состоять из 6 или более символов"
        case .wrongPassword:
            return "Ваш пароль неверен. Повторите попытку или восстановите пароль"
        default:
            return "Произошла неизвестная ошибка"
        }
    }
}
