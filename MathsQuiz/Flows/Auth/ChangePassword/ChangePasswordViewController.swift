//
//  ChangePasswordViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 22.12.2021.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    private var isKeyboardShown = false
    
    private let scrollView = UIScrollView()
    
    private let alertLabel: UILabel = {
        let label = UILabel()
        label.text = "При смене пароля новый пароль должен отличаться от предыдущего, как минимум, 6 символами"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = MQColor.gray
        label.font = MQFont.systemFont14
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextfield = MQStandardTextField(placeholder: "Пароль",
                                                        isAnimatedForm: false,
                                                        isSecured: true,
                                                        autocorrectionType: .no)
    private let confirmPasswordTextfield = MQStandardTextField(placeholder: "Подтверждение пароля",
                                                        isAnimatedForm: false,
                                                        isSecured: true,
                                                        autocorrectionType: .no)
    private let changeButton = MQStandardButton(title: "Изменить")
    
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

//MARK: - Setup views
private extension ChangePasswordViewController {
    func setupViews() {
        view.backgroundColor = MQColor.background
        
        setupScrollView()
        setupChangePasswordForm()
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
    
    func setupChangePasswordForm() {
        let stackView = UIStackView(arrangedSubviews: [passwordTextfield,
                                                       confirmPasswordTextfield])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(alertLabel)
        scrollView.addSubview(stackView)
        scrollView.addSubview(changeButton)
        
        NSLayoutConstraint.activate([
            passwordTextfield.heightAnchor.constraint(equalToConstant: 44),
            
            alertLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            alertLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            alertLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            
            stackView.topAnchor.constraint(equalTo: alertLabel.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            
            changeButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24),
            changeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 54),
            changeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -54),
            changeButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
        ])
    }
}

// MARK: - Setup observers and gestures recognizer
private extension ChangePasswordViewController {
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
