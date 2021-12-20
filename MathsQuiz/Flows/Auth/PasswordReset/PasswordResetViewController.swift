//
//  PasswordResetViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 19.12.2021.
//

import UIKit

class PasswordResetViewController: UIViewController {
    
    private var isKeyboardShown = false
    private let scrollView = UIScrollView()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Закрыть", for: .normal)
        button.setTitleColor(MQColor.ubeDefault, for: .normal)
        button.setTitleColor(MQColor.gray, for: .highlighted)
        button.titleLabel?.font = MQFont.systemFont16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let passwordResetLabel: UILabel = {
        let label = UILabel()
        label.text = "Привет, Данила!"
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
    
    private let textfield: OneImageTextfield = {
        let textfield = OneImageTextfield()
        textfield.layer.cornerRadius = 12
        textfield.backgroundColor = MQColor.ubeLight
        textfield.textColor = .black
        textfield.font = MQFont.systemFont16
        textfield.autocorrectionType = .no
        textfield.leftViewMode = UITextField.ViewMode.always
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let mailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        let image = UIImage(named: "mail")
        imageView.image = image
        return imageView
    }()
    
    private let sendButton = MQStandardButton(title: "Отправить")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        addTapGestureRecognizer()
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
        setupTextfield()
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
            closeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
    
    func setupPasswordResetLabel() {
        scrollView.addSubview(passwordResetLabel)
        
        NSLayoutConstraint.activate([
            passwordResetLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            passwordResetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordResetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setupEnterMailLabel() {
        scrollView.addSubview(enterMailLabel)
        
        NSLayoutConstraint.activate([
            enterMailLabel.topAnchor.constraint(equalTo: passwordResetLabel.bottomAnchor, constant: 24),
            enterMailLabel.leadingAnchor.constraint(equalTo: passwordResetLabel.leadingAnchor, constant: 20),
            enterMailLabel.trailingAnchor.constraint(equalTo: passwordResetLabel.trailingAnchor, constant: -20)
        ])
    }
    
    func setupTextfield() {
        scrollView.addSubview(textfield)
        
        textfield.leftView = mailImageView
        
        NSLayoutConstraint.activate([
            textfield.topAnchor.constraint(equalTo: enterMailLabel.bottomAnchor, constant: 24),
            textfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            textfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            textfield.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setupSendButton() {
        scrollView.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            sendButton.topAnchor.constraint(equalTo: textfield.bottomAnchor, constant: 24),
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 54),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -54),
            sendButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
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
                                               selector: #selector(keyboardWillBeHiden),
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
    
    @objc func keyboardWillBeHiden() {
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
