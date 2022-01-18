//
//  ViewController.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 13.12.2021.
//

import UIKit
import SnapKit
import AuthenticationServices

class LoginViewController: UIViewController, LoginViewInput {
    
    private var isKeyboardShown = false
    private let scrollView = UIScrollView()
    
    var presenter: (LoginPresenterOutput & LoginViewOutput)?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login_dog")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let orLogInWithLabel: UILabel = {
        let label = UILabel()
        label.text = "или\nавторизироваться с помощью"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = MQColor.gray
        label.font = MQFont.systemFont14
        return label
    }()
    
    private let noAccountYetLabel: UILabel = {
        let label = UILabel()
        label.text = "Еще нет аккаунта?"
        label.textColor = MQColor.gray
        label.font = MQFont.systemFont14
        return label
    }()
    
    private let forgotPasswordButton = MQPlainButton(title: "Забыли пароль?")
    
    private let googleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Google"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    private let appleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "AppleID"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    private let facebookButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Facebook"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    private let createNewAccountButton = MQPlainButton(title: "Создайте новый")

    private let loginButton = MQStandardButton(title: "Войти")
    private let emailTextField = MQStandardTextField(placeholder: "Email",
                                                     leftImageName: "mail",
                                                     autocorrectionType: .no)
    private let passwordTextField = MQStandardTextField(placeholder: "Пароль",
                                                        leftImageName: "block",
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
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
}

// MARK: - Setup views
private extension LoginViewController {
    func setupViews() {
        view.backgroundColor = .white
        setupScrollView()
        setupImageView()
        setupAuthForm()
        setupSignUpForm()
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupImageView() {
        scrollView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(scrollView)
            make.height.equalTo(view).multipliedBy(0.4)
        }
    }
    
    func setupAuthForm() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField,
                                                       passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        
        scrollView.addSubview(stackView)
        scrollView.addSubview(forgotPasswordButton)
        scrollView.addSubview(loginButton)
        
        emailTextField.heightAnchor.constraint(equalToConstant: MQOffset.offset44).isActive = true
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(MQOffset.offset24)
            make.centerX.equalTo(scrollView)
            make.trailing.leading.equalTo(scrollView).inset(MQOffset.offset28)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(MQOffset.offset8)
            make.trailing.equalTo(stackView.snp.trailing).inset(MQOffset.offset8)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(MQOffset.offset12)
            make.leading.equalTo(scrollView).offset(MQOffset.offset56)
            make.trailing.equalTo(scrollView).inset(MQOffset.offset56)
        }
    }
    
    func setupSignUpForm() {
        let buttonsStackView = UIStackView(arrangedSubviews: [googleButton,
                                                              appleButton,
                                                              facebookButton])
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 37
        buttonsStackView.distribution = .fillEqually
        
        let createAccountStackView = UIStackView(arrangedSubviews: [noAccountYetLabel,
                                                                    createNewAccountButton])
        createAccountStackView.axis = .horizontal
        createAccountStackView.spacing = 2
        
        scrollView.addSubview(orLogInWithLabel)
        scrollView.addSubview(buttonsStackView)
        scrollView.addSubview(createAccountStackView)
        
        googleButton.snp.makeConstraints { make in
            make.width.height.equalTo(MQOffset.offset44)
        }
        
        orLogInWithLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(MQOffset.offset12)
            make.centerX.equalTo(scrollView)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(orLogInWithLabel.snp.bottom).offset(MQOffset.offset12)
            make.centerX.equalTo(scrollView)
        }
        
        createAccountStackView.snp.makeConstraints { make in
            make.top.equalTo(buttonsStackView.snp.bottom).offset(MQOffset.offset16)
            make.centerX.equalTo(scrollView)
            make.bottom.equalTo(scrollView.snp.bottom).inset(MQOffset.offset8)
        }
    }
}

// MARK: - Setup targets
private extension LoginViewController {
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
    
    @objc func googleButtonTapped() {
        presenter?.viewDidSignInButtonTap(provider: .google, credentials: nil)
    }
    
    @objc func appleButtonTapped() {
        presenter?.viewDidSignInButtonTap(provider: .apple, credentials: nil)
    }
    
    @objc func facebookButtonTapped() {
        presenter?.viewDidSignInButtonTap(provider: .facebook, credentials: nil)
    }
    
    @objc func loginButtonTapped() {
        let credentials = Credentials(email: emailTextField.text ?? "",
                                      password: passwordTextField.text ?? "")
        presenter?.viewDidSignInButtonTap(provider: .emailPassword, credentials: credentials)
    }
    
    @objc func createNewAccountButtonTapped() {
        presenter?.viewDidSignUpTap()
    }
    
    @objc func forgotPasswordButtonTapped() {
        presenter?.viewDidPasswordResetButtonTap()
    }
}

// MARK: - Setup observers and gestures recognizer
private extension LoginViewController {
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

// MARK: - LoginViewInput
extension LoginViewController {
    func displayAlert(_ message: String?) {
        showAlert(title: "Ошибка", message: message)
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = view.window else {
            return UIWindow()
        }
        return window
    }
}
