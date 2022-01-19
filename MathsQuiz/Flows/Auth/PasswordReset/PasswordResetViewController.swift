//
//  PasswordResetViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 19.12.2021.
//

import UIKit
import SnapKit

class PasswordResetViewController: UIViewController, PasswordResetViewInput {
    
    var presenter: (PasswordResetPresenterOutput & PasswordResetViewOutput)?
    
    private var isKeyboardShown = false
    private let scrollView = UIScrollView()
    
    private let closeButton = MQPlainButton(title: "Закрыть")
    
    private let passwordResetLabel: UILabel = {
        let label = UILabel()
        label.text = "Восстановление пароля"
        label.font = MQFont.boldSystemFont24
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let enterMailLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите электронный адрес, указанный в личном кабинете. На него придет письмо со ссылкой для восстановления пароля."
        label.font = MQFont.systemFont14
        label.textColor = MQColor.gray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let textField = MQStandardTextField(placeholder: "Email",
                                                leftImageName: "mail",
                                                autocorrectionType: .no)
    
    private let sendButton = MQStandardButton(title: "Отправить")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        addTapGestureRecognizer()
        assignTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
}

// MARK: - Setup views
private extension PasswordResetViewController {
    func setupViews() {
        view.backgroundColor = MQColor.background
        
        setupScrollView()
        setupCloseButton()
        setupPasswordResetLabel()
        setupEnterMailLabel()
        setupTextField()
        setupSendButton()
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupCloseButton() {
        scrollView.addSubview(closeButton)
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(scrollView).offset(MQOffset.offset16)
            make.trailing.equalTo(view).inset(MQOffset.offset8)
        }
    }
    
    func setupPasswordResetLabel() {
        scrollView.addSubview(passwordResetLabel)
        
        passwordResetLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(MQOffset.offset48)
            make.leading.equalTo(view.snp.leading).offset(MQOffset.offset20)
            make.trailing.equalTo(view.snp.trailing).inset(MQOffset.offset20)
        }
    }
    
    func setupEnterMailLabel() {
        scrollView.addSubview(enterMailLabel)
        
        enterMailLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordResetLabel.snp.bottom).offset(MQOffset.offset24)
            make.leading.equalTo(passwordResetLabel).offset(MQOffset.offset20)
            make.trailing.equalTo(passwordResetLabel).inset(MQOffset.offset20)
        }
    }
    
    func setupTextField() {
        scrollView.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(enterMailLabel.snp.bottom).offset(MQOffset.offset24)
            make.leading.equalTo(view).offset(MQOffset.offset28)
            make.trailing.equalTo(view).inset(MQOffset.offset28)
            make.height.equalTo(MQOffset.offset44)
        }
    }
    
    func setupSendButton() {
        scrollView.addSubview(sendButton)
        
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(MQOffset.offset24)
            make.leading.equalTo(view).offset(MQOffset.offset52)
            make.trailing.equalTo(view).inset(MQOffset.offset52)
            make.bottom.equalTo(scrollView.snp.bottom).inset(MQOffset.offset20)
        }
    }
}

// MARK: - Targets
private extension PasswordResetViewController {
    func assignTargets() {
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    @objc func sendButtonTapped() {
        presenter?.viewDidSendButtonTap(textField.text)
    }
    
    @objc func closeButtonTapped() {
        presenter?.viewDidCloseButtonTap()
    }
}

// MARK: - Setup observers and gestures recognizer
private extension PasswordResetViewController {
    func addTapGestureRecognizer() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeShown),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    @objc func keyboardWillBeShown(notification: Notification) {
        guard !isKeyboardShown else { return }
        let info = notification.userInfo as NSDictionary?
        let keyboardSize = (info?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize?.height ?? 0.0, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        isKeyboardShown = true
    }
    
    @objc func keyboardWillBeHidden() {
        guard isKeyboardShown else { return }
        
        let contentInsets = UIEdgeInsets.zero
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        isKeyboardShown = false
    }
    
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
    }
}

// MARK: - PasswordResetViewInput
extension PasswordResetViewController {
    func displayAlert(_ message: String?) {
        self.showAlert(title: "Ошибка", message: message)
    }
}
