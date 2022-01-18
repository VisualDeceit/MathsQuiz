//
//  PasswordChangeViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 22.12.2021.
//

import UIKit
import SnapKit

class PasswordChangeViewController: UIViewController, PasswordChangeViewInput {

    var presenter: (PasswordChangePresenterOutput & PasswordChangeViewOutput)?
    
    private var isKeyboardShown = false
    
    private let scrollView = UIScrollView()
    
    private let alertLabel: UILabel = {
        let label = UILabel()
        label.text = "При смене пароля новый пароль должен отличаться от предыдущего, как минимум, 6 символами"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = MQColor.gray
        label.font = MQFont.systemFont14
        return label
    }()
    
    private let passwordTextField = MQStandardTextField(placeholder: "Пароль",
                                                        isAnimatedForm: false,
                                                        isSecured: true,
                                                        autocorrectionType: .no)
    private let confirmPasswordTextField = MQStandardTextField(placeholder: "Подтверждение пароля",
                                                               isAnimatedForm: false,
                                                               isSecured: true,
                                                               autocorrectionType: .no)
    private let changeButton = MQStandardButton(title: "Изменить")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        assignTargets()
        addTapGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addKeyboardObservers()
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
}

// MARK: - Setup views
private extension PasswordChangeViewController {
    func setupViews() {
        view.backgroundColor = MQColor.background
        
        setupScrollView()
        setupChangePasswordForm()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Изменить пароль"
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupChangePasswordForm() {
        let stackView = UIStackView(arrangedSubviews: [passwordTextField,
                                                       confirmPasswordTextField])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        scrollView.addSubview(alertLabel)
        scrollView.addSubview(stackView)
        scrollView.addSubview(changeButton)
        
        passwordTextField.heightAnchor.constraint(equalToConstant: MQOffset.offset44).isActive = true
        
        alertLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView).offset(MQOffset.offset20)
            make.leading.equalTo(view.snp.leading).offset(MQOffset.offset36)
            make.trailing.equalTo(view.snp.trailing).inset(MQOffset.offset36)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(alertLabel.snp.bottom).offset(MQOffset.offset24)
            make.leading.equalTo(view.snp.leading).offset(MQOffset.offset24)
            make.trailing.equalTo(view.snp.trailing).inset(MQOffset.offset24)
        }
        
        changeButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(MQOffset.offset24)
            make.leading.equalTo(view.snp.leading).offset(MQOffset.offset56)
            make.trailing.equalTo(view.snp.trailing).inset(MQOffset.offset56)
            make.bottom.equalTo(scrollView.snp.bottom).inset(MQOffset.offset8)
        }
    }

    func assignTargets() {
        changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
    }
    
    @objc func changeButtonTapped() {
        presenter?.viewDidChangePasswordButtonTap(.init(password: passwordTextField.text,
                                                        confirm: confirmPasswordTextField.text))
    }
}

// MARK: - Setup observers and gestures recognizer
private extension PasswordChangeViewController {
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

// MARK: - PasswordChangeViewInput
extension PasswordChangeViewController {
    
    func displayAlert(_ message: String?) {
        self.showAlert(title: "Ошибка", message: message)
    }
}
