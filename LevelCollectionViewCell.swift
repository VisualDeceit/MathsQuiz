//
//  LevelCell.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 19.12.2021.
//

import UIKit

class LevelCollectionViewCell: UICollectionViewCell, ConfigCell {
    typealias T = ActivityType
    
    static var reuseId: String = "UICollectionViewCell"
    
    private let levelNumLabel = UILabel()
    private var starImageView: [UIImageView] = []
    
    func configure(with value: ActivityType) {
        self.backgroundColor = value.color
        self.layer.cornerRadius = 20
        setupLevelNumLabel()
        setupStarImageView()
    }
    
    func setupLevelNumLabel() {
        levelNumLabel.text = "1"
        levelNumLabel.font = MQFont.systemFont48
        levelNumLabel.textAlignment = .center
        levelNumLabel.adjustsFontSizeToFitWidth = true
        levelNumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(levelNumLabel)
        
        NSLayoutConstraint.activate([
            levelNumLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            levelNumLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
        ])
    }
    
    func setupStarImageView() {
        for _ in 0...2 {
            let image = UIImageView()
            image.image = UIImage(systemName: "star.fill")
            image.contentMode = .scaleAspectFit
            image.tintColor = MQColor.lavenderDark
            image.transform = .init(rotationAngle: 0.26)
            image.heightAnchor.constraint(equalToConstant: 26).isActive = true
            image.widthAnchor.constraint(equalToConstant: 26).isActive = true
            starImageView.append(image)
        }
        
        let stackView = UIStackView(arrangedSubviews: starImageView)
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: levelNumLabel.bottomAnchor, constant: 2),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}
