//
//  OnboardingViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 26.12.2021.
//

import UIKit
import SnapKit

class OnboardingTemplateViewController: UIViewController {
    
    var index: Int
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = MQFont.boldSystemFont30
        label.textColor = MQColor.burntSienna
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let describeLabel: UILabel = {
        let label = UILabel()
        label.font = MQFont.systemFont14
        label.textColor = MQColor.gray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    init(title: String, image: UIImage, describe: String, index: Int) {
        self.index = index
        titleLabel.text = title
        imageView.image = image
        describeLabel.text = describe
        
        super.init(nibName: nil, bundle: nil)
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
        
        if index > 0 {
            imageView.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(MQOffset.offset16)
                make.leading.equalToSuperview().offset(MQOffset.offset80)
                make.trailing.equalToSuperview().inset(MQOffset.offset80)
                make.height.equalToSuperview().multipliedBy(0.5)
            }
        } else {
            imageView.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(MQOffset.offset16)
                make.leading.trailing.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(0.4)
            }
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(MQOffset.offset36)
            make.leading.equalToSuperview().offset(MQOffset.offset16)
            make.trailing.equalToSuperview().inset(MQOffset.offset16)
            make.height.equalTo(MQOffset.offset44)
        }
        
        describeLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(MQOffset.offset24)
            make.leading.equalToSuperview().offset(MQOffset.offset16)
            make.trailing.equalToSuperview().inset(MQOffset.offset16)
        }
    }
}
