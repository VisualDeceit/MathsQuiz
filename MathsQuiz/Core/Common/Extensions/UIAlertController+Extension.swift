//
//  UIAlertController+Extension.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 18.12.2021.
//

import UIKit

public extension UIAlertController {
    static func showAlert (
        title: String?,
        message: String?,
        tintColor: UIColor? = nil,
        inViewController viewController: UIViewController,
        actionBlock: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertActionOk = UIAlertAction(title: "OK", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
            if let actionBlock = actionBlock {
                actionBlock()
            }
        }
        
        alert.addAction(alertActionOk)
        DispatchQueue.main.async(execute: {
            viewController.present(alert, animated: true, completion: nil)
            if let tintColor = tintColor {
                alert.view.tintColor = tintColor
            }
        })
    }
    
    static func showActionSheet(
        title: String?,
        message: String?,
        viewController: UIViewController,
        actions: [UIAlertAction]?,
        cancelTitle: String,
        tintColor: UIColor?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIDevice.current.userInterfaceIdiom == .pad ? .alert : .actionSheet)
        alert.addActions(actions)
        let alertActionCancel = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        alert.addAction(alertActionCancel)
        DispatchQueue.main.async(execute: {
            viewController.present(alert, animated: true, completion: nil)
            if let tintColor = tintColor {
                alert.view.tintColor = tintColor
            }
        })
    }
    
    func addAction(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?) {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        addAction(action)
    }
    
    func addCancelAction(title: String?) {
        let action = UIAlertAction(title: title, style: .cancel, handler: nil)
        addAction(action)
    }
}

// MARK: - Add methods
public extension UIAlertController {
    func addActions(_ actions: [UIAlertAction]?) {
        actions?.forEach { self.addAction($0) }
    }
}
