//
//  SignUpViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 14.12.2021.
//

import UIKit

///SignUp view input interface
protocol SignUpViewInput: AnyObject {}

class SignUpViewController: UIViewController {
    
    private var isKeyboardShown = false
    
    private let scrollView = UIScrollView()
    
    var presenter: SignUpViewOutput!
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dog1")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let alreadyExistLabel: UILabel = {
        let label = UILabel()
        label.text = "Уже есть аккаунт?"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = Colors.lavenderLight
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войдите", for: .normal)
        button.setTitleColor(Colors.lavenderDark, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = Colors.whiteColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameTextField = MathsQuizStandardTextField(placeholder: "Имя и фамилия")
    private let emailTextField = MathsQuizStandardTextField(placeholder: "Email")
    private let passwordTextField = MathsQuizStandardTextField(placeholder: "Пароль",
                                                      isSecured: true,
                                                      autocorrectionType: .no)
    private let confirmPasswordTextField = MathsQuizStandardTextField(placeholder: "Подтверждение пароля",
                                                             isSecured: true,
                                                             autocorrectionType: .no)
    private let signUpButton = MathsQuizStandardButton(title: "Зарегистрироваться")
    
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
private extension SignUpViewController {
    func setupViews() {
        setupScrollView()
        setupImageView()
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
    
    func setupImageView() {
        scrollView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
    }
    
    func setupSignUpForm() {
        let stackView = UIStackView(arrangedSubviews: [nameTextField,
                                                       emailTextField,
                                                       passwordTextField,
                                                       confirmPasswordTextField])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        scrollView.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 26),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            
            signUpButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 43),
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
            stackView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 42),
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
                               action: #selector(signInButtonTapped),
                               for: .touchUpInside)
    }
    
    @objc func signUpButtonTapped() {
        self.presenter.signUpButtonTapped()
    }
    
    @objc func signInButtonTapped() {
        self.presenter.signInButtonTapped()
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
extension SignUpViewController: SignUpViewInput {
    
}
