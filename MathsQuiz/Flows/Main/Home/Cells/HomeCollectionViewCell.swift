//
//  HomeCollectionViewCell.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 17.12.2021.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell, ConfigCell {
    typealias T = Activity
    
    static let reuseId: String = "HomeCollectionViewCell"
    
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
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: MQOffset.single),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -MQOffset.single)
        ])
    }
    
    private func setupLevelContainerView() {
        levelContainerView.backgroundColor = MQColor.background
        levelContainerView.layer.cornerRadius = self.frame.width / 15
        levelContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(levelContainerView)
        
        NSLayoutConstraint.activate([
            levelContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -MQOffset.double),
            levelContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: MQOffset.single * 5),
            levelContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -MQOffset.single * 5),
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
            levelCountLabel.leadingAnchor.constraint(equalTo: levelContainerView.leadingAnchor, constant: MQOffset.single),
            levelCountLabel.trailingAnchor.constraint(equalTo: levelContainerView.trailingAnchor, constant: -MQOffset.single)
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
            circleContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: MQOffset.double * 2),
            circleContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -MQOffset.double),
            circleContainerView.heightAnchor.constraint(equalToConstant: MQOffset.single * 9),
            circleContainerView.widthAnchor.constraint(equalToConstant: MQOffset.single * 9),
            
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
            circularProgressBarView.heightAnchor.constraint(equalToConstant: MQOffset.double * 3),
            circularProgressBarView.widthAnchor.constraint(equalToConstant: MQOffset.double * 3)
        ])
    }
}
