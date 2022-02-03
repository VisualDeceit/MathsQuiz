//
//  LevelCell.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 19.12.2021.
//

import UIKit
import SnapKit

class LevelCollectionViewCell: UICollectionViewCell {
    
    static var reuseId: String = "kLevelCollectionViewCell"
    
    private let levelNumLabel = UILabel()
    private var starImageView: [UIImageView] = []
    private let lockImageView = UIImageView()
    
    func configure(level: Level, type: ActivityType) {
        self.backgroundColor = type.color

        if -1 == level.attempts {
            setupBlockedCellForm(type: type)
        } else {
            setupUnblockedCellForm(level: level, type: type)
        }
    }
    
    func setupUnblockedCellForm(level: Level, type: ActivityType) {
        levelNumLabel.text = "\(level.number)"
        levelNumLabel.font = MQFont.systemFont48
        
        for index in 1...3 {
            let image = UIImageView()
            image.image = UIImage(systemName: "star.fill")
            image.contentMode = .scaleAspectFit
            if index <= level.attempts {
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
        
        self.addSubview(levelNumLabel)
        self.addSubview(stackView)
        
        levelNumLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(MQOffset.offset8)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(levelNumLabel.snp.bottom).offset(MQOffset.offset4)
            make.leading.equalToSuperview().offset(MQOffset.offset4)
            make.trailing.bottom.equalToSuperview().inset(MQOffset.offset4)
        }
    }
    
    func setupBlockedCellForm(type: ActivityType) {
        lockImageView.image = UIImage(systemName: "lock.fill")
        lockImageView.tintColor = type.highlightedСolor
        lockImageView.contentMode = .scaleAspectFit
        
        self.addSubview(lockImageView)
        
        lockImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(MQOffset.offset12)
            make.trailing.bottom.equalToSuperview().inset(MQOffset.offset12)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 20
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        levelNumLabel.text = nil
        starImageView.forEach { $0.image = nil }
        starImageView.removeAll()
        lockImageView.image = nil
    }
}
