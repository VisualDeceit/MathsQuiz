//
//  UserAccountViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 17.12.2021.
//

import UIKit

class UserAccountViewController: UIViewController, UserAccountViewInput {
    
    var presenter: (UserAccountPresenterOutput & UserAccountViewOutput)?
    
    private let scrollView = UIScrollView()
    
    private let userPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "userPhoto")
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let changePhotoButton: UIButton = {
        let button = UIButton()
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
        label.font = MQFont.systemFont14
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
}

// MARK: - Setup views
private extension UserAccountViewController {
    func setupViews() {
        view.backgroundColor = MQColor.background
        
        setupScrollView()
        setupUserDataForm()
        setupMailForm()
        setupResultContainerView()
        setupButtons()
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
    
    func setupUserDataForm() {
        scrollView.addSubview(userPhoto)
        userPhoto.addSubview(changePhotoButton)
        scrollView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            userPhoto.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            userPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userPhoto.heightAnchor.constraint(equalToConstant: 120),
            userPhoto.widthAnchor.constraint(equalToConstant: 120),
            
            changePhotoButton.topAnchor.constraint(equalTo: userPhoto.bottomAnchor, constant: -15),
            changePhotoButton.centerXAnchor.constraint(equalTo: userPhoto.centerXAnchor),
            changePhotoButton.widthAnchor.constraint(equalToConstant: 73),
            changePhotoButton.heightAnchor.constraint(equalToConstant: 20),
            
            nameLabel.topAnchor.constraint(equalTo: changePhotoButton.bottomAnchor, constant: 14),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupMailForm() {
        scrollView.addSubview(mailContainerView)
        mailContainerView.addSubview(mailImageView)
        mailContainerView.addSubview(mailLabel)
        
        NSLayoutConstraint.activate([
            mailContainerView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            mailContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            mailContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            mailContainerView.heightAnchor.constraint(equalToConstant: 44),
            
            mailImageView.topAnchor.constraint(equalTo: mailContainerView.topAnchor, constant: 10),
            mailImageView.leadingAnchor.constraint(equalTo: mailContainerView.leadingAnchor, constant: 10),
            mailImageView.bottomAnchor.constraint(equalTo: mailContainerView.bottomAnchor, constant: -10),
            
            mailLabel.centerYAnchor.constraint(equalTo: mailImageView.centerYAnchor),
            mailLabel.leadingAnchor.constraint(equalTo: mailImageView.trailingAnchor, constant: 6)
        ])
    }
    
    func setupResultContainerView() {
        scrollView.addSubview(resultContainerView)
        
        NSLayoutConstraint.activate([
            resultContainerView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 67),
            resultContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            resultContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            resultContainerView.heightAnchor.constraint(equalToConstant: 160)
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
            stackView.topAnchor.constraint(equalTo: resultContainerView.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 54),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -54),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - Setup targets
private extension UserAccountViewController {
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
    
    @objc func changePhotoButtonTapped() {}
    
    @objc func myDataButtonTapped() {}
    
    @objc func changePasswordButtonTapped() {}
    
    @objc func exitButtonTapped() {}
}
