//
//  ViewController.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 13.12.2021.
//

import UIKit

///SignIn view input interface
protocol SignInViewInput: AnyObject {}

class SignInViewController: UIViewController {
    
    private var isKeyboardShown = false
    
    private let scrollView = UIScrollView()
    
    var presenter: SignInViewOutput!
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dog1")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let orLogInWithLabel: UILabel = {
        let label = UILabel()
        label.text = "или\nавторизироваться с помощью"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = Colors.mqGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let noAccountYetLabel: UILabel = {
        let label = UILabel()
        label.text = "Еще нет аккаунта?"
        label.textColor = Colors.mqGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Забыли пароль?", for: .normal)
        button.setTitleColor(Colors.burntSienna, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let googleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Google"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let appleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "AppleID"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let facebookButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Facebook"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let createNewAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Создайте новый", for: .normal)
        button.setTitleColor(Colors.burntSienna, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = Colors.whiteColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let loginButton = MathsQuizStandardButton(title: "Войти")
    private let emailTextField = MathsQuizStandardTextField(placeholder: "Email",
                                                            leftImageName: "Outline",
                                                            autocorrectionType: .no)
    private let passwordTextField = MathsQuizStandardTextField(placeholder: "Пароль",
                                                               leftImageName: "Monochrome",
                                                               isSecured: true,
                                                               autocorrectionType: .no)
    
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

//MARK: - Setup views
private extension SignInViewController {
    func setupViews() {
        view.backgroundColor = Colors.whiteColor
        setupScrollView()
        setupImageView()
        setupAuthForm()
        setupSignUpForm()
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
    
    func setupImageView() {
        scrollView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
    }
    
    func setupAuthForm() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField,
                                                       passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        scrollView.addSubview(forgotPasswordButton)
        scrollView.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 27),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -27),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -7),
            
            loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 12),
            loginButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 54),
            loginButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -54)
        ])
    }
    
    func setupSignUpForm() {
        let buttonsStackView = UIStackView(arrangedSubviews: [googleButton,
                                                              appleButton,
                                                              facebookButton])
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 37
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let createAccountStackView = UIStackView(arrangedSubviews: [noAccountYetLabel,
                                                                    createNewAccountButton])
        createAccountStackView.axis = .horizontal
        createAccountStackView.spacing = 2
        createAccountStackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(orLogInWithLabel)
        scrollView.addSubview(buttonsStackView)
        scrollView.addSubview(createAccountStackView)
        
        NSLayoutConstraint.activate([
            googleButton.widthAnchor.constraint(equalToConstant: 45),
            googleButton.heightAnchor.constraint(equalToConstant: 45),
            
            orLogInWithLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 14),
            orLogInWithLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            buttonsStackView.topAnchor.constraint(equalTo: orLogInWithLabel.bottomAnchor, constant: 10),
            buttonsStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            createAccountStackView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 15),
            createAccountStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            createAccountStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
        ])
    }
}

// MARK: - Setup targets
private extension SignInViewController {
    func addTargetToButtons() {
        forgotPasswordButton.addTarget(self,
                                       action: #selector(forgotPasswordButtonTapped),
                                       for: .touchUpInside)
        
        googleButton.addTarget(self,
                               action: #selector(googleButtonTapped),
                               for: .touchUpInside)
        
        appleButton.addTarget(self,
                              action: #selector(appleButtonTapped),
                              for: .touchUpInside)
        
        facebookButton.addTarget(self,
                                 action: #selector(facebookButtonTapped),
                                 for: .touchUpInside)
        
        createNewAccountButton.addTarget(self,
                                         action: #selector(createNewAccountButtonTapped),
                                         for: .touchUpInside)
        
        loginButton.addTarget(self,
                              action: #selector(loginButtonTapped),
                              for: .touchUpInside)
    }
    
    @objc func forgotPasswordButtonTapped() {
        self.presenter.forgotPasswordButtonTapped()
    }
    
    @objc func googleButtonTapped() {
        self.presenter.googleButtonTapped()
    }
    
    @objc func appleButtonTapped() {
        self.presenter.appleButtonTapped()
    }
    
    @objc func facebookButtonTapped() {
        self.presenter.facebookButtonTapped()
    }
    
    @objc func createNewAccountButtonTapped() {
        self.presenter.createNewAccountButtonTapped()
    }
    
    @objc func loginButtonTapped() {
        self.presenter.loginButtonTapped()
    }
}

// MARK: - Setup observers and gestures recognizer
private extension SignInViewController {
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

//MARK:- Commands from presenter
extension SignInViewController: SignInViewInput {
    // обработка команд от presenter
}
