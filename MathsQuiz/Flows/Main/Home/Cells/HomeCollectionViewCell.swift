//
//  HomeCollectionViewCell.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 17.12.2021.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell, ConfigCell {
    typealias T = Activity
    
    static var reuseId: String = "HomeCollectionViewCell"
    
    private let nameLabel = UILabel()
    private let levelContainerView = UIView()
    private let levelCountLabel = UILabel()
    private let circleContainerView = UIView()
    private let progressNumLabel = UILabel()
    private let circularProgressBarView = MQCircularProgressBar(frame: .zero)
    
    func configure(with value: Activity) {
        self.backgroundColor = value.type.color
        self.layer.cornerRadius = 24
        setupNameLabel(text: value.type.rawValue)
        setupLevelContainerView()
        setupLevelCountLabel(with: "\(value.total)")
        setupProgressForm()
        setUpCircularProgressBarView(toValue: Double(value.progress) / Double(value.total))
        progressNumLabel.text = "\(value.progress)"
    }
    
    private func setupNameLabel(text: String) {
        nameLabel.text = text
        nameLabel.font = MQFont.systemFont24
        nameLabel.textAlignment = .center
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    }
    
    private func setupLevelContainerView() {
        levelContainerView.backgroundColor = MQColor.background
        levelContainerView.layer.cornerRadius = self.frame.width / 15
        levelContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(levelContainerView)
        
        NSLayoutConstraint.activate([
            levelContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            levelContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22),
            levelContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -22),
            levelContainerView.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func setupLevelCountLabel(with text: String) {
        levelCountLabel.text = text
        levelCountLabel.font = MQFont.systemFont12
        levelCountLabel.textAlignment = .center
        levelCountLabel.adjustsFontSizeToFitWidth = true
        levelCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        levelContainerView.addSubview(levelCountLabel)
        
        NSLayoutConstraint.activate([
            levelCountLabel.centerYAnchor.constraint(equalTo: levelContainerView.centerYAnchor),
            levelCountLabel.leadingAnchor.constraint(equalTo: levelContainerView.leadingAnchor, constant: 2),
            levelCountLabel.trailingAnchor.constraint(equalTo: levelContainerView.trailingAnchor, constant: -2)
        ])
    }
    
    private func setupProgressForm() {
        circleContainerView.backgroundColor = MQColor.background
        circleContainerView.layer.cornerRadius = 18
        circleContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        progressNumLabel.text = "3"
        progressNumLabel.font = MQFont.systemFont12
        progressNumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(circleContainerView)
        circleContainerView.addSubview(progressNumLabel)
        
        NSLayoutConstraint.activate([
            circleContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            circleContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            circleContainerView.heightAnchor.constraint(equalToConstant: 36),
            circleContainerView.widthAnchor.constraint(equalToConstant: 36),
            
            progressNumLabel.centerXAnchor.constraint(equalTo: circleContainerView.centerXAnchor),
            progressNumLabel.centerYAnchor.constraint(equalTo: circleContainerView.centerYAnchor)
        ])
    }
    
    private func setUpCircularProgressBarView(toValue: Double) {
        circleContainerView.addSubview(circularProgressBarView)
        
        circularProgressBarView.progressTo(value: toValue)
        
        circularProgressBarView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            circularProgressBarView.centerXAnchor.constraint(equalTo: circleContainerView.centerXAnchor),
            circularProgressBarView.centerYAnchor.constraint(equalTo: circleContainerView.centerYAnchor),
            circularProgressBarView.heightAnchor.constraint(equalToConstant: 25),
            circularProgressBarView.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
}
