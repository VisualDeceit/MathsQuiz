//
//  MainCollectionViewCell.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 17.12.2021.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell, ConfigCell {
    typealias T = MainCollectionViewData
    
    static var reuseId: String = "MainCollectionViewCell"
    
    private let nameLabel = UILabel()
    private let levelContainerView = UIView()
    private let levelCountLabel = UILabel()
    
    func configCell(with value: MainCollectionViewData) {
        self.backgroundColor = value.color
        self.layer.cornerRadius = 24
        setupNameLabel(text: value.name)
        setupLevelContainerView()
        setupLevelCountLabel(with: value.levelCount)
    }
    
    private func setupNameLabel(text: String) {
        nameLabel.text = text
        nameLabel.font = UIFont.systemFont(ofSize: 24)
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
        levelContainerView.backgroundColor = Colors.whiteColor
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
        levelCountLabel.font = UIFont.systemFont(ofSize: 12)
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
}

