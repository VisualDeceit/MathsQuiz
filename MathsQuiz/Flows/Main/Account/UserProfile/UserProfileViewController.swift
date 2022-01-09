//
//  UserAccountViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 17.12.2021.
//

import UIKit

class UserProfileViewController: UIViewController, UserProfileViewInput {
    
    var presenter: (UserProfilePresenterOutput & UserProfileViewOutput)?
    
    private let scrollView = UIScrollView()
    
    private let userPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user_placeholder")
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let changePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Изменить", for: .normal)
        button.titleLabel?.font = MQFont.systemFont10
        button.backgroundColor = MQColor.ubeDefault
        button.tintColor = MQColor.background
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Вася Пупкин"
        label.font = MQFont.boldSystemFont24
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mailContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = MQColor.ubeLight
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let mailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mail")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let mailLabel: UILabel = {
        let label = UILabel()
        label.text = "test@mail.com"
        label.font = MQFont.systemFont16
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let resultContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0xC4C4C4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let myDataButton = MQStandardButton(title: "Мои данные")
    private let changePasswordButton = MQStandardButton(title: "Изменить пароль")
    private let exitButton = MQStandardButton(title: "Выйти")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        addTargetToButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        presenter?.viewDidLoad()
    }
}

// MARK: - Setup views
private extension UserProfileViewController {
    func setupViews() {
        view.backgroundColor = MQColor.background
        
        setupScrollView()
        setupUserDataForm()
        setupMailForm()
        setupResultContainerView()
        setupButtons()
    }
    
    func setupNavigationBar() {
        title = "Профиль"
        navigationController?.navigationBar.tintColor = MQColor.ubeDefault
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupUserDataForm() {
        scrollView.addSubview(userPhoto)
        userPhoto.addSubview(changePhotoButton)
        scrollView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            userPhoto.topAnchor.constraint(equalTo: scrollView.topAnchor),
            userPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userPhoto.heightAnchor.constraint(equalToConstant: MQOffset.double * 15),
            userPhoto.widthAnchor.constraint(equalToConstant: MQOffset.double * 15),
            
            changePhotoButton.topAnchor.constraint(equalTo: userPhoto.bottomAnchor, constant: -MQOffset.double * 2),
            changePhotoButton.centerXAnchor.constraint(equalTo: userPhoto.centerXAnchor),
            changePhotoButton.widthAnchor.constraint(equalToConstant: MQOffset.double * 9),
            changePhotoButton.heightAnchor.constraint(equalToConstant: MQOffset.single * 5),
            
            nameLabel.topAnchor.constraint(equalTo: changePhotoButton.bottomAnchor, constant: MQOffset.single * 3),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupMailForm() {
        scrollView.addSubview(mailContainerView)
        mailContainerView.addSubview(mailImageView)
        mailContainerView.addSubview(mailLabel)
        
        NSLayoutConstraint.activate([
            mailContainerView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: MQOffset.double),
            mailContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MQOffset.double * 3),
            mailContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MQOffset.double * 3),
            mailContainerView.heightAnchor.constraint(equalToConstant: MQOffset.single * 11),
            
            mailImageView.topAnchor.constraint(equalTo: mailContainerView.topAnchor, constant: MQOffset.double),
            mailImageView.leadingAnchor.constraint(equalTo: mailContainerView.leadingAnchor, constant: MQOffset.double),
            mailImageView.bottomAnchor.constraint(equalTo: mailContainerView.bottomAnchor, constant: -MQOffset.double),
            
            mailLabel.centerYAnchor.constraint(equalTo: mailImageView.centerYAnchor),
            mailLabel.leadingAnchor.constraint(equalTo: mailImageView.trailingAnchor, constant: MQOffset.double)
        ])
    }
    
    func setupResultContainerView() {
        scrollView.addSubview(resultContainerView)
        
        NSLayoutConstraint.activate([
            resultContainerView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: MQOffset.double * 8),
            resultContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MQOffset.single * 3),
            resultContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MQOffset.single * 3),
            resultContainerView.heightAnchor.constraint(equalToConstant: MQOffset.double * 20)
        ])
    }
    
    func setupButtons() {
        let stackView = UIStackView(arrangedSubviews: [myDataButton,
                                                       changePasswordButton,
                                                       exitButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: resultContainerView.bottomAnchor, constant: MQOffset.double * 2),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MQOffset.double * 7),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MQOffset.double * 7),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -MQOffset.single * 5)
        ])
    }
}

// MARK: - Setup targets
private extension UserProfileViewController {
    func addTargetToButtons() {
        changePhotoButton.addTarget(self,
                                    action: #selector(changePhotoButtonTapped),
                                    for: .touchUpInside)
        myDataButton.addTarget(self,
                               action: #selector(myDataButtonTapped),
                               for: .touchUpInside)
        changePasswordButton.addTarget(self,
                                       action: #selector(changePasswordButtonTapped),
                                       for: .touchUpInside)
        exitButton.addTarget(self,
                             action: #selector(exitButtonTapped),
                             for: .touchUpInside)
    }
    
    @objc func changePhotoButtonTapped() {
        presenter?.viewDidChangePhotoButtonTap()
    }
    
    @objc func myDataButtonTapped() {
        presenter?.viewDidMyDataButtonTap()
    }
    
    @objc func changePasswordButtonTapped() {
        presenter?.viewDidPasswordChangeButtonTap()
    }
    
    @objc func exitButtonTapped() {
        let alert = UIAlertController(title: "Уверены, что хотите выйти из своего профиля?",
                                      message: nil, preferredStyle: .alert)
        alert.addCancelAction(title: "Отмена")
        alert.addAction(title: "Выйти", style: .destructive) { [weak self] _ in
            self?.presenter?.viewDidLogoutButtonTap()
        }
        self.present(alert, animated: true, completion: nil)
    }
}

extension UserProfileViewController {
    func displayProfile(userName: String, email: String) {
        nameLabel.text = userName
        mailLabel.text = email
    }
    
    func displayAlert(_ message: String?) {
        showAlert(title: "Ошибка", message: message)
    }
}
