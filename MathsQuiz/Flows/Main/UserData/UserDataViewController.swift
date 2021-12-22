//
//  UserDataViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 16.12.2021.
//

import UIKit

class UserDataViewController: UIViewController, UserDataViewInput {
    
    var presenter: (UserDataPresenterOutput & UserDataViewOutput)?
    
    private var isKeyboardShown = false
    
    private let scrollView = UIScrollView()
    private let cityTextfield = MQStandardTextField(placeholder: "Город",
                                                    isAnimatedForm: false,
                                                    autocorrectionType: .no)
    private let nameTextfield = MQStandardTextField(placeholder: "Имя",
                                                    isAnimatedForm: false,
                                                    autocorrectionType: .no)
    private let surnameTextfield = MQStandardTextField(placeholder: "Фамилия",
                                                       isAnimatedForm: false,
                                                       autocorrectionType: .no)
    private let sexTextfield = MQStandardTextField(placeholder: "Пол",
                                                   isAnimatedForm: false,
                                                   autocorrectionType: .no)
    private let birthdayTextfield = MQStandardTextField(placeholder: "Дата рождения",
                                                        isAnimatedForm: false,
                                                        autocorrectionType: .no)
    private let phoneNumberTextfield = MQStandardTextField(placeholder: "Номер телефона",
                                                           isAnimatedForm: false)
    private let locationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.tintColor = MQColor.burntSienna
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let sexPickerView = UIPickerView()
    private let datePickerView = UIDatePicker()
    private let saveButton = MQStandardButton(title: "Сохранить")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        addTargetToButtons()
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
private extension UserDataViewController {
    func setupViews() {
        view.backgroundColor = MQColor.background
        
        sexTextfield.text = "Мужской"
        
        setupNavigationBar()
        setupScrollView()
        setupPhoneNumberTextfield()
        setupPickerViews()
        setupCityTextfield()
        setupUserDataForm()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Мои данные"
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
    
    func setupPhoneNumberTextfield() {
        phoneNumberTextfield.keyboardType = .numberPad
        phoneNumberTextfield.delegate = self
    }
    
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func setupPickerViews() {
        sexPickerView.delegate = self
        sexPickerView.dataSource = self
        sexPickerView.backgroundColor = MQColor.ubeLight
        
        datePickerView.datePickerMode = .date
        datePickerView.locale = Locale(identifier: "Ru_ru")
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        }
        datePickerView.backgroundColor = MQColor.ubeLight
        
        sexTextfield.inputView = sexPickerView
        birthdayTextfield.inputView = datePickerView
    }
    
    func setupCityTextfield() {
        cityTextfield.addSubview(locationButton)
        
        NSLayoutConstraint.activate([
            locationButton.centerYAnchor.constraint(equalTo: cityTextfield.centerYAnchor),
            locationButton.trailingAnchor.constraint(equalTo: cityTextfield.trailingAnchor, constant: -10),
            locationButton.heightAnchor.constraint(equalToConstant: 24),
            locationButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setupUserDataForm() {
        let pickerViewsStackView = UIStackView(arrangedSubviews: [sexTextfield,
                                                                  birthdayTextfield])
        pickerViewsStackView.axis = .horizontal
        pickerViewsStackView.distribution = .fillEqually
        pickerViewsStackView.spacing = 10
        
        let stackView = UIStackView(arrangedSubviews: [cityTextfield,
                                                       surnameTextfield,
                                                       nameTextfield,
                                                       pickerViewsStackView,
                                                       phoneNumberTextfield])
        stackView.axis = .vertical
        stackView.spacing = 19
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        scrollView.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            surnameTextfield.heightAnchor.constraint(equalToConstant: 44),
            
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
        locationButton.addTarget(self,
                                 action: #selector(locationButtonTapped),
                                 for: .touchUpInside)
        datePickerView.addTarget(self,
                                 action: #selector(dateDidChange),
                                 for: .valueChanged)
    }
    
    @objc func saveButtonTapped() {
        presenter?.viewDidSaveButtonTap()
    }
    
    @objc func locationButtonTapped() {
    }
    
    @objc func dateDidChange() {
        let formatter = DateFormatter()
        formatter.calendar = datePickerView.calendar
        formatter.locale = Locale(identifier: "Ru_ru")
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        let dateString = formatter.string(from: datePickerView.date)
        birthdayTextfield.text = dateString
    }
}

// MARK: - Setup extension of textfield
extension UserDataViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "+X (XXX) XXX-XXXX", phone: newString)
        return false
    }
}

// MARK: - Setup extension of pickerVIew
extension UserDataViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let sex = ["Мужской", "Женский"]
        return sex[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let sex = ["Мужской", "Женский"]
        sexTextfield.text = sex[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
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

// MARK: - UserDataViewInput
extension UserDataViewController {
}
