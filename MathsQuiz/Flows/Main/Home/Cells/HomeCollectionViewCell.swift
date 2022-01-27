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
    
    func configure(with activity: Activity) {
        self.backgroundColor = activity.type.color
        self.layer.cornerRadius = 24
        setupNameLabel(text: activity.type.rawValue)
        setupLevelContainerView()
        setupLevelCountLabel(with: activity.type.totalLevels)
        setupProgressForm()
        if activity.type.totalLevels == 0 {
            setUpCircularProgressBarView(toValue: 0)
        } else {
            setUpCircularProgressBarView(toValue: Double(activity.levels.count - 1) / Double(activity.type.totalLevels))
        }
        progressNumLabel.text = "\(activity.levels.count - 1)"
    }
    
    private func setupNameLabel(text: String) {
        nameLabel.text = text
        nameLabel.font = MQFont.systemFont24
        nameLabel.textAlignment = .center
        nameLabel.adjustsFontSizeToFitWidth = true
        
        self.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(MQOffset.offset4)
            make.trailing.equalToSuperview().inset(MQOffset.offset4)
        }
    }
    
    private func setupLevelContainerView() {
        levelContainerView.backgroundColor = MQColor.background
        
        self.addSubview(levelContainerView)
        
        levelContainerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(MQOffset.offset8)
            make.leading.equalToSuperview().offset(MQOffset.offset24)
            make.trailing.equalToSuperview().inset(MQOffset.offset24)
            make.height.equalTo(MQOffset.offset24)
        }
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
        
        levelContainerView.addSubview(levelCountLabel)
        
        levelCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(levelContainerView.snp.centerY)
            make.leading.equalTo(levelContainerView.snp.leading).offset(MQOffset.offset4)
            make.trailing.equalTo(levelContainerView.snp.trailing).inset(MQOffset.offset4)
        }
    }
    
    private func setupProgressForm() {
        circleContainerView.backgroundColor = MQColor.background
        
        progressNumLabel.text = "3"
        progressNumLabel.font = MQFont.systemFont12
        
        self.addSubview(circleContainerView)
        circleContainerView.addSubview(progressNumLabel)
        
        circleContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(MQOffset.offset16)
            make.trailing.equalToSuperview().inset(MQOffset.offset8)
            make.height.width.equalTo(MQOffset.offset36)
        }
        
        progressNumLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(circleContainerView)
        }
    }
    
    private func setUpCircularProgressBarView(toValue: Double) {
        circleContainerView.addSubview(circularProgressBarView)
        
        circularProgressBarView.progressTo(value: toValue)
                
        circularProgressBarView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(circleContainerView)
            make.height.width.equalTo(MQOffset.offset24)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 24
        levelContainerView.layer.cornerRadius = self.frame.width / 15
        circleContainerView.layer.cornerRadius = 18
    }
}
