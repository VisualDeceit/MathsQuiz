//
//  OnboardingViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 26.12.2021.
//

import UIKit

class OnboardingTemplateViewController: UIViewController {
    
    private var isFirstPage = false
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = MQFont.boldSystemFont30
        label.textColor = MQColor.burntSienna
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let describeLabel: UILabel = {
        let label = UILabel()
        label.font = MQFont.systemFont14
        label.textColor = MQColor.gray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(title: String, image: UIImage, describe: String, isFirstPage: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        
        titleLabel.text = title
        imageView.image = image
        describeLabel.text = describe
        self.isFirstPage = isFirstPage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
}

// MARK: - Setup views
private extension OnboardingTemplateViewController {
    func setupViews() {
        view.backgroundColor = MQColor.background

        setupOnboardingForm()
    }
    
    func setupOnboardingForm() {
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(describeLabel)
        
        if !isFirstPage {
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
                imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
            ])
        } else {
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
            ])
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            titleLabel.heightAnchor.constraint(equalToConstant: 45),
            
            describeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            describeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            describeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
    }
}
