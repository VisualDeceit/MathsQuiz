//
//  SignUpViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 14.12.2021.
//

import UIKit

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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let createNewAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Cоздайте учетную запись, чтобы вы могли использовать Maths Quiz"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = MQColor.gray
        label.font = MQFont.systemFont14
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let alreadyExistLabel: UILabel = {
        let label = UILabel()
        label.text = "Уже есть аккаунт?"
        label.textColor = MQColor.gray
        label.font = MQFont.systemFont14
        label.translatesAutoresizingMaskIntoConstraints = false
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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupTitleLabels() {
        scrollView.addSubview(newAccountLabel)
        scrollView.addSubview(createNewAccountLabel)
        
        NSLayoutConstraint.activate([
            newAccountLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 48),
            newAccountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newAccountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            createNewAccountLabel.topAnchor.constraint(equalTo: newAccountLabel.bottomAnchor, constant: 7),
            createNewAccountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 51),
            createNewAccountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -51)
        ])
    }
    
    func setupSignUpForm() {
        let stackView = UIStackView(arrangedSubviews: [nameTextField,
                                                       emailTextField,
                                                       passwordTextField,
                                                       confirmPasswordTextField])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        scrollView.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            stackView.topAnchor.constraint(equalTo: createNewAccountLabel.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            
            signUpButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 54),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -54)
        ])
    }
    
    func setupSignInForm() {
        let stackView = UIStackView(arrangedSubviews: [alreadyExistLabel,
                                                       signInButton])
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 24),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
        ])
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
    
    func needShowAlert(title: String, message: String?) {
        showAlert(title: title, message: message)
    }
}
