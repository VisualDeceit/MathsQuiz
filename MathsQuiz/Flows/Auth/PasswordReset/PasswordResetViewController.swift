//
//  PasswordResetViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 19.12.2021.
//

import UIKit

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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let enterMailLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите электронный адрес, указанный в личном кабинете. На него придет письмо со ссылкой для восстановления пароля."
        label.font = MQFont.systemFont14
        label.textColor = MQColor.gray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupCloseButton() {
        scrollView.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: MQOffset.offset16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MQOffset.offset8)
        ])
    }
    
    func setupPasswordResetLabel() {
        scrollView.addSubview(passwordResetLabel)
        
        NSLayoutConstraint.activate([
            passwordResetLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: MQOffset.offset48),
            passwordResetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MQOffset.offset20),
            passwordResetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MQOffset.offset20)
        ])
    }
    
    func setupEnterMailLabel() {
        scrollView.addSubview(enterMailLabel)
        
        NSLayoutConstraint.activate([
            enterMailLabel.topAnchor.constraint(equalTo: passwordResetLabel.bottomAnchor, constant: MQOffset.offset24),
            enterMailLabel.leadingAnchor.constraint(equalTo: passwordResetLabel.leadingAnchor, constant: MQOffset.offset20),
            enterMailLabel.trailingAnchor.constraint(equalTo: passwordResetLabel.trailingAnchor, constant: -MQOffset.offset20)
        ])
    }
    
    func setupTextField() {
        scrollView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: enterMailLabel.bottomAnchor, constant: MQOffset.offset24),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MQOffset.offset28),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MQOffset.offset28),
            textField.heightAnchor.constraint(equalToConstant: MQOffset.offset44)
        ])
    }
    
    func setupSendButton() {
        scrollView.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            sendButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: MQOffset.offset24),
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MQOffset.offset52),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MQOffset.offset52),
            sendButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -MQOffset.offset20)
        ])
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
