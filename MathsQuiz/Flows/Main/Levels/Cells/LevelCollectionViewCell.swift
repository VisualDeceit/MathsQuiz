//
//  LevelCell.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 19.12.2021.
//

import UIKit

class LevelCollectionViewCell: UICollectionViewCell {
    
    static var reuseId: String = "kLevelCollectionViewCell"
    
    private let levelNumLabel = UILabel()
    private var starImageView: [UIImageView] = []
    private let lockImageView = UIImageView()
    
    func configure(level: Level, type: ActivityType) {
        self.backgroundColor = type.color
        self.layer.cornerRadius = 20

        if -1 == level.completion {
            setupBlockedCellForm(type: type)
        } else {
            setupUnblockedCellForm(level: level, type: type)
        }
    }
    
    func setupUnblockedCellForm(level: Level, type: ActivityType) {
        levelNumLabel.text = "\(level.index)"
        levelNumLabel.font = MQFont.systemFont48
        levelNumLabel.textAlignment = .center
        levelNumLabel.adjustsFontSizeToFitWidth = true
        levelNumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        for i in 1...3 {
            let image = UIImageView()
            image.image = UIImage(systemName: "star.fill")
            image.contentMode = .scaleAspectFit
            if i <= level.completion {
                image.tintColor = type.highlightedСolor
            } else {
                image.tintColor = MQColor.background
            }
            image.transform = .init(rotationAngle: 0.26)
            image.heightAnchor.constraint(equalToConstant: 26).isActive = true
            starImageView.append(image)
        }
        
        let stackView = UIStackView(arrangedSubviews: starImageView)
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(levelNumLabel)
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            levelNumLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            levelNumLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: MQOffset.single * 5),
        
            stackView.topAnchor.constraint(equalTo: levelNumLabel.bottomAnchor, constant: MQOffset.single),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: MQOffset.single),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -MQOffset.single),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -MQOffset.single)
        ])
    }
    
    func setupBlockedCellForm(type: ActivityType) {
        lockImageView.image = UIImage(systemName: "lock.fill")
        lockImageView.tintColor = type.highlightedСolor
        lockImageView.contentMode = .scaleAspectFit
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(lockImageView)
        
        NSLayoutConstraint.activate([
            lockImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: MQOffset.single * 3),
            lockImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: MQOffset.single * 3),
            lockImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -MQOffset.single * 3),
            lockImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -MQOffset.single * 3)
        ])
    }
}
