//
//  SignUpViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 14.12.2021.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController, SignUpViewInput {

    private var isKeyboardShown = false
    private let scrollView = UIScrollView()
    
    var presenter: (SignUpPresenterOutput & SignUpViewOutput)?
    
    private let newAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Новая учетная запись"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = MQFont.boldSystemFont24
        return label
    }()
    
    private let createNewAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Cоздайте учетную запись, чтобы вы могли использовать Maths Quiz"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = MQColor.gray
        label.font = MQFont.systemFont14
        return label
    }()
    
    private let alreadyExistLabel: UILabel = {
        let label = UILabel()
        label.text = "Уже есть аккаунт?"
        label.textColor = MQColor.gray
        label.font = MQFont.systemFont14
        return label
    }()
    
    private let signInButton = MQPlainButton(title: "Войти")

    private let nameTextField = MQStandardTextField(placeholder: "Имя и фамилия",
                                                    leftImageName: "person",
                                                    autocorrectionType: .no)
    private let emailTextField = MQStandardTextField(placeholder: "Email",
                                                     leftImageName: "mail",
                                                     autocorrectionType: .no)
    private let passwordTextField = MQStandardTextField(placeholder: "Пароль",
                                                        leftImageName: "block",
                                                        isSecured: true,
                                                        autocorrectionType: .no)
    private let confirmPasswordTextField = MQStandardTextField(placeholder: "Подтверждение пароля",
                                                               leftImageName: "block",
                                                               isSecured: true,
                                                               autocorrectionType: .no)
    private let signUpButton = MQStandardButton(title: "Создать")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addTargetToButtons()
        addTapGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObservers()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
}

// MARK: - Setup views
private extension SignUpViewController {
    func setupViews() {
        view.backgroundColor = .white
        setupScrollView()
        setupTitleLabels()
        setupSignUpForm()
        setupSignInForm()
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupTitleLabels() {
        scrollView.addSubview(newAccountLabel)
        scrollView.addSubview(createNewAccountLabel)
        
        newAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(MQOffset.offset48)
            make.leading.equalTo(view.snp.leading).offset(MQOffset.offset20)
            make.trailing.equalTo(view.snp.trailing).inset(MQOffset.offset20)
        }
        
        createNewAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(newAccountLabel.snp.bottom).offset(MQOffset.offset8)
            make.leading.equalTo(view.snp.leading).offset(MQOffset.offset48)
            make.trailing.equalTo(view.snp.trailing).inset(MQOffset.offset48)
        }
    }
    
    func setupSignUpForm() {
        let stackView = UIStackView(arrangedSubviews: [nameTextField,
                                                       emailTextField,
                                                       passwordTextField,
                                                       confirmPasswordTextField])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        scrollView.addSubview(stackView)
        scrollView.addSubview(signUpButton)
        
        nameTextField.heightAnchor.constraint(equalToConstant: MQOffset.offset44).isActive = true
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(createNewAccountLabel.snp.bottom).offset(MQOffset.offset24)
            make.leading.equalTo(view.snp.leading).offset(MQOffset.offset28)
            make.trailing.equalTo(view.snp.trailing).inset(MQOffset.offset28)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(MQOffset.offset24)
            make.leading.equalTo(view.snp.leading).offset(MQOffset.offset56)
            make.trailing.equalTo(view.snp.trailing).inset(MQOffset.offset56)
        }
    }
    
    func setupSignInForm() {
        let stackView = UIStackView(arrangedSubviews: [alreadyExistLabel,
                                                       signInButton])
        stackView.axis = .horizontal
        stackView.spacing = 2
        
        scrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(MQOffset.offset24)
            make.centerX.equalTo(view)
            make.bottom.equalTo(scrollView.snp.bottom).inset(MQOffset.offset8)
        }
    }
}

// MARK: - Setup targets
private extension SignUpViewController {
    func addTargetToButtons() {
        signUpButton.addTarget(self,
                               action: #selector(signUpButtonTapped),
                               for: .touchUpInside)
        signInButton.addTarget(self,
                               action: #selector(loginButtonTapped),
                               for: .touchUpInside)
    }
    
    @objc func signUpButtonTapped() {
        let signUpData = SignUpData(username: nameTextField.text ?? "",
                                    email: emailTextField.text ?? "" ,
                                    password: passwordTextField.text ?? "",
                                    passwordConfirm: confirmPasswordTextField.text ?? "")
        presenter?.viewDidSignUpButtonTap(data: signUpData)
    }
    
    @objc func loginButtonTapped() {
        presenter?.viewDidLoginButtonTap()
    }
}

// MARK: - Setup observers and gestures recognizer
private extension SignUpViewController {
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

// MARK: - SignUpViewInput
extension SignUpViewController {
    func displayAlert(_ message: String?) {
        showAlert(title: "Ошибка", message: message)
    }
}
