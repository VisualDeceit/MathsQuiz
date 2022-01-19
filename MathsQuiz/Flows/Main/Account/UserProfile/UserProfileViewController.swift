//
//  UserAccountViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 17.12.2021.
//

import UIKit
import SnapKit

class UserProfileViewController: UIViewController, UserProfileViewInput {
    
    var presenter: (UserProfilePresenterOutput & UserProfileViewOutput)?
    
    private let scrollView = UIScrollView()
    
    private let userPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user_placeholder")
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.contentMode = .scaleAspectFit
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
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Вася Пупкин"
        label.font = MQFont.boldSystemFont24
        return label
    }()
    
    private let mailContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = MQColor.ubeLight
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let mailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mail")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let mailLabel: UILabel = {
        let label = UILabel()
        label.text = "test@mail.com"
        label.font = MQFont.systemFont16
        return label
    }()
    
    private let resultContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0xC4C4C4)
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
        
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupUserDataForm() {
        scrollView.addSubview(userPhoto)
        userPhoto.addSubview(changePhotoButton)
        scrollView.addSubview(nameLabel)
        
        userPhoto.snp.makeConstraints { make in
            make.top.equalTo(scrollView)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(MQOffset.offset120)
        }
        
        changePhotoButton.snp.makeConstraints { make in
            make.top.equalTo(userPhoto.snp.bottom).inset(MQOffset.offset16)
            make.centerX.equalTo(userPhoto.snp.centerX)
            make.width.equalTo(MQOffset.offset72)
            make.height.equalTo(MQOffset.offset20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(changePhotoButton.snp.bottom).offset(MQOffset.offset16)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupMailForm() {
        scrollView.addSubview(mailContainerView)
        mailContainerView.addSubview(mailImageView)
        mailContainerView.addSubview(mailLabel)
        
        mailContainerView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(MQOffset.offset8)
            make.leading.equalTo(view.snp.leading).offset(MQOffset.offset28)
            make.trailing.equalTo(view.snp.trailing).inset(MQOffset.offset28)
            make.height.equalTo(MQOffset.offset44)
        }
        
        mailImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(mailContainerView).offset(MQOffset.offset8)
            make.bottom.equalTo(mailContainerView.snp.bottom).inset(MQOffset.offset8)
        }
        
        mailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(mailImageView)
            make.leading.equalTo(mailImageView.snp.trailing).offset(MQOffset.offset8)
        }
    }
    
    func setupResultContainerView() {
        scrollView.addSubview(resultContainerView)
        
        resultContainerView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(MQOffset.offset68)
            make.leading.equalTo(view.snp.leading).offset(MQOffset.offset28)
            make.trailing.equalTo(view.snp.trailing).inset(MQOffset.offset28)
            make.height.equalTo(MQOffset.offset160)
        }
    }
    
    func setupButtons() {
        let stackView = UIStackView(arrangedSubviews: [myDataButton,
                                                       changePasswordButton,
                                                       exitButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 16
        
        scrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(resultContainerView.snp.bottom).offset(MQOffset.offset16)
            make.leading.equalTo(view.snp.leading).offset(MQOffset.offset56)
            make.trailing.equalTo(view.snp.trailing).inset(MQOffset.offset56)
            make.bottom.equalTo(scrollView.snp.bottom).inset(MQOffset.offset20)
        }
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
