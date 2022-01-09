//
//  UserProfileDetailViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 16.12.2021.
//

import UIKit

class UserProfileDetailViewController: UIViewController, UserProfileDetailViewInput {
    
    var presenter: (UserProfileDetailPresenterOutput & UserProfileDetailViewOutput)?
    
    private var isKeyboardShown = false
    private let scrollView = UIScrollView()
    private let cityTextField = MQStandardTextField(placeholder: "Город",
                                                    isAnimatedForm: false,
                                                    autocorrectionType: .no)
    private let nameTextField = MQStandardTextField(placeholder: "Имя",
                                                    isAnimatedForm: false,
                                                    autocorrectionType: .no)
    private let surnameTextField = MQStandardTextField(placeholder: "Фамилия",
                                                       isAnimatedForm: false,
                                                       autocorrectionType: .no)
    private let sexTextField = MQStandardTextField(placeholder: "Пол",
                                                   isAnimatedForm: false,
                                                   autocorrectionType: .no)
    private let birthdayTextField = MQStandardTextField(placeholder: "Дата рождения",
                                                        isAnimatedForm: false,
                                                        autocorrectionType: .no)
    private let phoneNumberTextField = MQStandardTextField(placeholder: "Номер телефона",
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
        addTargetToTextFields()
        addTapGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addKeyboardObservers()
        setupNavigationBar()
        presenter?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
}

// MARK: - Setup views
private extension UserProfileDetailViewController {
    func setupViews() {
        view.backgroundColor = MQColor.background
        
        sexTextField.text = "Выбрать"
        
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
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.delegate = self
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
        
        sexTextField.inputView = sexPickerView
        birthdayTextField.inputView = datePickerView
    }
    
    func setupCityTextfield() {
        cityTextField.addSubview(locationButton)
        
        NSLayoutConstraint.activate([
            locationButton.centerYAnchor.constraint(equalTo: cityTextField.centerYAnchor),
            locationButton.trailingAnchor.constraint(equalTo: cityTextField.trailingAnchor, constant: -MQOffset.offset8),
            locationButton.heightAnchor.constraint(equalToConstant: MQOffset.offset24),
            locationButton.widthAnchor.constraint(equalToConstant: MQOffset.offset24)
        ])
    }
    
    func setupUserDataForm() {
        let pickerViewsStackView = UIStackView(arrangedSubviews: [sexTextField,
                                                                  birthdayTextField])
        pickerViewsStackView.axis = .horizontal
        pickerViewsStackView.distribution = .fillEqually
        pickerViewsStackView.spacing = 10
        
        let stackView = UIStackView(arrangedSubviews: [cityTextField,
                                                       surnameTextField,
                                                       nameTextField,
                                                       pickerViewsStackView,
                                                       phoneNumberTextField])
        stackView.axis = .vertical
        stackView.spacing = 19
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        scrollView.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            surnameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: MQOffset.offset24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MQOffset.offset28),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MQOffset.offset28),
            
            saveButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: MQOffset.offset24),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 54),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -54),
            saveButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -MQOffset.offset8)
        ])
    }
}

// MARK: - Setup targets
private extension UserProfileDetailViewController {
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
    
    func addTargetToTextFields() {
        sexTextField.addTarget(self, action: #selector(sexTextFieldActivate), for: .editingDidBegin)
    }
    
    @objc func sexTextFieldActivate() {
        if let sex = presenter?.userProfile?.sex {
            sexTextField.text = sex.rawValue
        } else {
            sexTextField.text = Sex.allCases[0].rawValue
        }
    }
    
    @objc func saveButtonTapped() {
        presenter?.viewDidSaveButtonTap(city: cityTextField.text,
                                        lastName: surnameTextField.text,
                                        firstName: nameTextField.text,
                                        sex: sexTextField.text,
                                        birthday: birthdayTextField.text,
                                        phone: phoneNumberTextField.text)
    }
    
    @objc func locationButtonTapped() {
    }
    
    @objc func dateDidChange() {
        birthdayTextField.text = DateFormatter.shortLocalStyle.string(from: datePickerView.date)
    }
}

// MARK: - Setup extension of textfield
extension UserProfileDetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "+X (XXX) XXX-XX-XX", phone: newString)
        return false
    }
}

// MARK: - Setup extension of pickerVIew
extension UserProfileDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Sex.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Sex.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sexTextField.text = Sex.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
}

// MARK: - Setup observers and gestures recognizer
private extension UserProfileDetailViewController {
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

// MARK: - UserProfileDetailViewInput
extension UserProfileDetailViewController {
    
    func displayUserProfile() {
        cityTextField.text = presenter?.userProfile?.city
        nameTextField.text = presenter?.userProfile?.firstName
        surnameTextField.text = presenter?.userProfile?.lastName

        if let sex = presenter?.userProfile?.sex,
           let index = Sex.allCases.firstIndex(of: sex) {
            sexPickerView.selectRow(index, inComponent: 0, animated: false)
            sexTextField.text = sex.rawValue
        }
        if let date = presenter?.userProfile?.birthday {
            datePickerView.date = date
            birthdayTextField.text = DateFormatter.shortLocalStyle.string(from: date)
        }
        
        phoneNumberTextField.text = format(with: "+X (XXX) XXX-XX-XX",
                                           phone: presenter?.userProfile?.phone ?? "")
    }
}
