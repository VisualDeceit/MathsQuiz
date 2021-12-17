//
//  UserDataViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 16.12.2021.
//

import UIKit

class UserDataViewController: UIViewController {
    
    private var isKeyboardShown = false
    
    private let scrollView = UIScrollView()
    private let phoneNumberTextfield = MathsQuizStandardTextField(placeholder: "Номер телефона", isAnimatedForm: false)
    private let surnameTextfield = MathsQuizStandardTextField(placeholder: "Фамилия",
                                                              isAnimatedForm: false,
                                                              autocorrectionType: .no)
    private let nameTextfield = MathsQuizStandardTextField(placeholder: "Имя",
                                                           isAnimatedForm: false,
                                                           autocorrectionType: .no)
    private let birthdayTextfield = MathsQuizStandardTextField(placeholder: "Дата рождения",
                                                               isAnimatedForm: false,
                                                               autocorrectionType: .no)
    private let sexTextfield = MathsQuizStandardTextField(placeholder: "Пол",
                                                          isAnimatedForm: false,
                                                          autocorrectionType: .no)
    private let saveButton = MathsQuizStandardButton(title: "Сохранить")
    
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
private extension UserDataViewController {
    func setupViews() {
        view.backgroundColor = Colors.whiteColor
        
        setupScrollView()
        setupUserDataForm()
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupUserDataForm() {
        let stackView = UIStackView(arrangedSubviews: [phoneNumberTextfield,
                                                       surnameTextfield,
                                                       nameTextfield,
                                                       birthdayTextfield,
                                                       sexTextfield])
        stackView.axis = .vertical
        stackView.spacing = 19
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        scrollView.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            phoneNumberTextfield.heightAnchor.constraint(equalToConstant: 44),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            
            saveButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 54),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -54),
            saveButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
        ])
    }
}

// MARK: - Setup targets
private extension UserDataViewController {
    func addTargetToButtons() {
        saveButton.addTarget(self,
                             action: #selector(saveButtonTapped),
                             for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {}
}

// MARK: - Setup observers and gestures recognizer
private extension UserDataViewController {
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
