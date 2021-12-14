//
//  MyMapsStandardTextField.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 14.12.2021.
//

import Foundation
import UIKit

class MathsQuizStandardTextField: UITextField {
    
    convenience init(placeholder: String,
                     isSecured: Bool = false,
                     accessibilityIdentifier: String? = nil,
                     autocorrectionType: UITextAutocorrectionType? = nil) {
        self.init()
        self.accessibilityIdentifier = accessibilityIdentifier
        self.isSecureTextEntry = isSecured
        self.layer.cornerRadius = 12
        self.layer.borderColor = Colors.lavenderDark.cgColor
        self.layer.borderWidth = 1.5
        self.placeholder = placeholder
        if let autocorrectionType = autocorrectionType {
            self.autocorrectionType = autocorrectionType
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20))
    }
}
