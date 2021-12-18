//
//  Presentable.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 16.12.2021.
//

import UIKit

protocol Presentable {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    func toPresent() -> UIViewController? {
        return self
    }
    
    func showAlert(title: String, message: String? = nil) {
        UIAlertController.showAlert(title            : title,
                                    message          : message,
                                    inViewController : self,
                                    actionBlock      : nil)
    }
}
