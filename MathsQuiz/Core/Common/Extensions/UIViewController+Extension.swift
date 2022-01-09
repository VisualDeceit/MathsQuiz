//
//  UIViewController+Extension.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 23.12.2021.
//

import UIKit

extension UIViewController: Presentable {
    func toPresent() -> UIViewController? {
        return self
    }
    
    func showAlert(title: String, message: String? = nil) {
        UIAlertController.showAlert(title: title,
                                    message: message,
                                    inViewController: self,
                                    actionBlock: nil)
    }
}
