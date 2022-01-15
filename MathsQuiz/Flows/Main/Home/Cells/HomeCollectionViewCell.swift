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
        setupLevelCountLabel(with: value.total)
        setupProgressForm()
        if value.total == 0 {
            setUpCircularProgressBarView(toValue: 0)
        } else {
            setUpCircularProgressBarView(toValue: Double(value.levels.count - 1) / Double(value.total))
        }
        progressNumLabel.text = "\(value.levels.count - 1)"
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
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: MQOffset.offset4),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -MQOffset.offset4)
        ])
    }
    
    private func setupLevelContainerView() {
        levelContainerView.backgroundColor = MQColor.background
        levelContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(levelContainerView)
        
        NSLayoutConstraint.activate([
            levelContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -MQOffset.offset8),
            levelContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: MQOffset.offset24),
            levelContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -MQOffset.offset24),
            levelContainerView.heightAnchor.constraint(equalToConstant: MQOffset.offset24)
        ])
    }
    
    private func setupLevelCountLabel(with number: Int) {
        switch number {
        case 0:
            levelCountLabel.text = "Нет доступных"
        default:
            levelCountLabel.text = "\(number) уровней"
        }
       
        levelCountLabel.font = MQFont.systemFont12
        levelCountLabel.textAlignment = .center
        levelCountLabel.adjustsFontSizeToFitWidth = true
        levelCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        levelContainerView.addSubview(levelCountLabel)
        
        NSLayoutConstraint.activate([
            levelCountLabel.centerYAnchor.constraint(equalTo: levelContainerView.centerYAnchor),
            levelCountLabel.leadingAnchor.constraint(equalTo: levelContainerView.leadingAnchor, constant: MQOffset.offset4),
            levelCountLabel.trailingAnchor.constraint(equalTo: levelContainerView.trailingAnchor, constant: -MQOffset.offset4)
        ])
    }
    
    private func setupProgressForm() {
        circleContainerView.backgroundColor = MQColor.background
        circleContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        progressNumLabel.text = "3"
        progressNumLabel.font = MQFont.systemFont12
        progressNumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(circleContainerView)
        circleContainerView.addSubview(progressNumLabel)
        
        NSLayoutConstraint.activate([
            circleContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: MQOffset.offset16),
            circleContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -MQOffset.offset8),
            circleContainerView.heightAnchor.constraint(equalToConstant: MQOffset.offset36),
            circleContainerView.widthAnchor.constraint(equalToConstant: MQOffset.offset36),
            
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
            circularProgressBarView.heightAnchor.constraint(equalToConstant: MQOffset.offset24),
            circularProgressBarView.widthAnchor.constraint(equalToConstant: MQOffset.offset24)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 24
        levelContainerView.layer.cornerRadius = self.frame.width / 15
        circleContainerView.layer.cornerRadius = 18
    }
}
