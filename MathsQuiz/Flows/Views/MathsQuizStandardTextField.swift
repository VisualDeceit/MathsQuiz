//
//  MyMapsStandardTextField.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 14.12.2021.
//

import UIKit

class MathsQuizStandardTextField: UITextField {
    
    private var isTextSecured = true
    private var isAnimatedForm = true
    
    lazy var label = UILabel()
    
    convenience init(placeholder: String,
                     leftImageName: String? = nil,
                     isAnimatedForm: Bool = true,
                     isSecured: Bool = false,
                     accessibilityIdentifier: String? = nil,
                     autocorrectionType: UITextAutocorrectionType? = nil) {
        self.init()
        self.accessibilityIdentifier = accessibilityIdentifier
        self.isSecureTextEntry = isSecured
        self.layer.cornerRadius = 12
        self.backgroundColor = Colors.ubeLight
        
        self.isAnimatedForm = isAnimatedForm
        
        if let autocorrectionType = autocorrectionType {
            self.autocorrectionType = autocorrectionType
        }
        
        if let imageName = leftImageName {
            addLeftImageView(imageName: imageName)
        }
        
        addLabel(with: placeholder)
        
        if isSecured {
            addSecuredButton()
        }
        
        if isAnimatedForm {
            addTargets()
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addLeftImageView(imageName: String) {
        self.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        let image = UIImage(named: imageName)
        imageView.image = image
        self.leftView = imageView
    }
    
    func addLabel(with text: String) {
        label.text = text
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = Colors.mqGray
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        
        if isAnimatedForm {
            NSLayoutConstraint.activate([
                label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40)
            ])
        } else {
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
                label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
            ])
        }
    }
    
    func addSecuredButton() {
        self.rightViewMode = .always
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = Colors.mqGray
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(securedButtonTapped), for: .touchUpInside)
        self.rightView = button
    }
    
    @objc func securedButtonTapped(_ sender: UIButton) {
        isTextSecured.toggle()
        if !isTextSecured {
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            self.isSecureTextEntry = false
        } else {
            sender.setImage(UIImage(systemName: "eye"), for: .normal)
            self.isSecureTextEntry = true
        }
    }
    
    @objc func textfieldeditingDidBegin() {
        UIView.animate(withDuration: 0.2) {
            self.label.transform = CGAffineTransform(translationX: 0, y: -10)
        }
    }
    
    @objc func textfielDidEndEditing() {
        if self.text == "" {
            UIView.animate(withDuration: 1) {
                self.label.transform = .identity
            }
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        if isAnimatedForm {
            return bounds.inset(by: UIEdgeInsets(top: 10, left: 40, bottom: 0, right: 30))
        } else {
            return bounds.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 30))
        }
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        if isAnimatedForm {
            return bounds.inset(by: UIEdgeInsets(top: 10, left: 40, bottom: 0, right: 30))
        } else {
            return bounds.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 30))
        }
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 10, y: bounds.midY - 12, width: 24, height: 24)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.maxX - 30, y: bounds.midY - 8, width: 25, height: 16)
    }
    
    func addTargets() {
        self.addTarget(self, action: #selector(textfieldeditingDidBegin), for: .editingDidBegin)
        self.addTarget(self, action: #selector(textfielDidEndEditing), for: .editingDidEnd)
    }
}
