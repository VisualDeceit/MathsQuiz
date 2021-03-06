//
//  MyMapsStandardTextField.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 14.12.2021.
//

import UIKit

class MQStandardTextField: UITextField {
    
    private var isTextSecured = true
    private var isAnimatedForm = true
    private var isEdited = false
    
    let label = UILabel()
    
    init(placeholder: String,
         leftImageName: String? = nil,
         isAnimatedForm: Bool = true,
         isSecured: Bool = false,
         accessibilityIdentifier: String? = nil,
         autocorrectionType: UITextAutocorrectionType? = nil
    ) {
        super.init(frame: .zero)
        
        self.accessibilityIdentifier = accessibilityIdentifier
        self.isSecureTextEntry = isSecured
        self.backgroundColor = MQColor.ubeLight
        self.textColor = .black
        self.font = MQFont.systemFont16
        
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        if !isAnimatedForm {
            label.font = MQFont.systemFont12
        } else {
            label.font = MQFont.systemFont16
        }
        
        label.textColor = MQColor.gray
        self.addSubview(label)
        
        if isAnimatedForm {
            label.snp.makeConstraints { make in
                make.centerY.equalTo(self)
                make.leading.equalTo(self).offset(MQOffset.offset40)
            }
        } else {
            label.snp.makeConstraints { make in
                make.top.equalTo(self).offset(MQOffset.offset4)
                make.leading.equalTo(self).offset(MQOffset.offset12)
            }
        }
    }
    
    func addSecuredButton() {
        self.rightViewMode = .always
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = MQColor.gray
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
    
    private func placeholderAnimation() -> CAAnimationGroup {
        let toSmallFontSize = CABasicAnimation(keyPath: "transform.scale")
        toSmallFontSize.fromValue = isEditing ? 1.0 : 0.75
        toSmallFontSize.toValue = !isEditing ? 1.0 : 0.75
        
        let toChangePosition = CABasicAnimation(keyPath: "position.y")
        toChangePosition.fromValue = label.layer.position.y - ( isEditing ? 0 : 12)
        toChangePosition.toValue = label.layer.position.y - ( !isEditing ? 0 : 12)

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [toSmallFontSize, toChangePosition]
        animationGroup.duration = isEditing ? 0.2 : 0.1
        animationGroup.fillMode = .both
        animationGroup.isRemovedOnCompletion = false

        return animationGroup
    }
    @objc func textFieldEditingDidBegin() {
        guard let text = text, text.isEmpty else { return }
        isEdited.toggle()
        label.layer.add(placeholderAnimation(), forKey: "")
    }
    
    @objc func textFieldDidEndEditing() {
        guard let text = text, text.isEmpty else { return }
            isEdited.toggle()
            label.layer.add(placeholderAnimation(), forKey: "")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        if isAnimatedForm {
            return bounds.inset(by: UIEdgeInsets(top: 10, left: 40, bottom: 0, right: 30))
        } else {
            return bounds.inset(by: UIEdgeInsets(top: 10, left: 12, bottom: 0, right: 30))
        }
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        if isAnimatedForm {
            return bounds.inset(by: UIEdgeInsets(top: 10, left: 40, bottom: 0, right: 30))
        } else {
            return bounds.inset(by: UIEdgeInsets(top: 10, left: 12, bottom: 0, right: 30))
        }
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 10, y: bounds.midY - 12, width: 24, height: 24)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.maxX - 30, y: bounds.midY - 8, width: 25, height: 16)
    }
    
    func addTargets() {
        self.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        self.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        label.setAnchorPoint(anchorPoint: CGPoint(x: 0, y: 0.5))
        self.layer.cornerRadius = 12
    }
}
