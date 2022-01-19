//
//  ScoreViewController.swift
//  MathsQuiz
//
//  Created by Karakhanyan Tigran on 12.01.2022.
//

import UIKit
import Lottie

class ScoreViewController: UIViewController {
    
    var activityType: ActivityType?
    
    private let mainContainerView = UIView()
    private let bottomCircleContainterView = UIView()
    private let middleCircleContainerView = UIView()
    private let topCircleContainerView = UIView()
    private var congratulationFormStackView = UIStackView()
    private var bottomStackView = UIStackView()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Закрыть", for: .normal)
        button.setTitleColor(MQColor.lavenderDark, for: .normal)
        button.setTitleColor(MQColor.lavenderLight, for: .highlighted)
        button.titleLabel?.font = MQFont.systemFont16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let fireworkAnimationView: AnimationView = {
        let view = AnimationView()
        let path = Bundle.main.path(forResource: "fireworkAnimation", ofType: "json") ?? ""
        view.animation = Animation.filepath(path)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scoreTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Счет"
        label.font = MQFont.boldSystemFont18
        label.textColor = MQColor.lavenderDark
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreNumLabel: UILabel = {
        let label = UILabel()
        label.font = MQFont.systemFont64
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pointTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Очка"
        label.font = MQFont.systemFont18
        label.textColor = MQColor.lavenderDark
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let congratulationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Поздравляем!"
        label.font = MQFont.boldSystemFont24
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = MQFont.systemFont16
        label.textColor = MQColor.lavenderDark
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bestScoreTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Лучший результат"
        label.font = MQFont.boldSystemFont14
        label.textColor = MQColor.lavenderDark
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bestScoreNumLabel: UILabel = {
        let label = UILabel()
        label.font = MQFont.boldSystemFont14
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Общее время"
        label.font = MQFont.boldSystemFont14
        label.textColor = MQColor.lavenderDark
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalTimeNumLabel: UILabel = {
        let label = UILabel()
        label.font = MQFont.boldSystemFont14
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let completionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Завершение"
        label.font = MQFont.boldSystemFont14
        label.textColor = MQColor.lavenderDark
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let completionNumLabel: UILabel = {
        let label = UILabel()
        label.font = MQFont.boldSystemFont14
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let errorsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ошибки"
        label.font = MQFont.boldSystemFont14
        label.textColor = MQColor.lavenderDark
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let errorsNumLabel: UILabel = {
        let label = UILabel()
        label.font = MQFont.boldSystemFont14
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let resetLevelsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "resetLevels"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let homeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "home"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "share"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupViewsCornerRadius()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fireworkAnimationView.play { _ in
            self.fireworkAnimationView.stop()
            self.fireworkAnimationView.removeFromSuperview()
        }
    }
}

// MARK: - Setup views
private extension ScoreViewController {
    func setupViews() {
        view.backgroundColor = MQColor.background
        setupCloseButton()
        setupBottomButtons()
        setupMainContainerView()
        setupCircleContainerViews()
        setupScoreLabels()
        setupCongratulationForm()
        setupFireworkAnimation()
        setupResultForm()
        setupResultsText()
    }
    
    func setupCloseButton() {
        mainContainerView.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: mainContainerView.topAnchor, constant: MQOffset.offset8),
            closeButton.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -MQOffset.offset8)
        ])
    }

    func setupBottomButtons() {
        bottomStackView.addArrangedSubview(resetLevelsButton)
        bottomStackView.addArrangedSubview(homeButton)
        bottomStackView.addArrangedSubview(shareButton)

        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .fillEqually
        bottomStackView.spacing = 20
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            resetLevelsButton.heightAnchor.constraint(equalToConstant: MQOffset.offset64),
            resetLevelsButton.widthAnchor.constraint(equalToConstant: MQOffset.offset64),
            
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -MQOffset.offset16),
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupMainContainerView() {
        mainContainerView.backgroundColor = MQColor.lavenderLight
        mainContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainContainerView)
        
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor, constant: -20)
        ])
    }
    
    func setupCircleContainerViews() {
        let circleContainerColor = MQColor.lavenderDark
        let middleLighterColor = circleContainerColor.lighter(by: 20)
        let topLighterColor = circleContainerColor.lighter(by: 50)
        
        bottomCircleContainterView.backgroundColor = circleContainerColor
        middleCircleContainerView.backgroundColor = middleLighterColor
        topCircleContainerView.backgroundColor = topLighterColor
        
        bottomCircleContainterView.translatesAutoresizingMaskIntoConstraints = false
        middleCircleContainerView.translatesAutoresizingMaskIntoConstraints = false
        topCircleContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        mainContainerView.addSubview(bottomCircleContainterView)
        bottomCircleContainterView.addSubview(middleCircleContainerView)
        middleCircleContainerView.addSubview(topCircleContainerView)
        
        NSLayoutConstraint.activate([
            bottomCircleContainterView.topAnchor.constraint(equalTo: mainContainerView.topAnchor, constant: MQOffset.offset40),
            bottomCircleContainterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomCircleContainterView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.27),
            bottomCircleContainterView.widthAnchor.constraint(equalTo: bottomCircleContainterView.heightAnchor),
            
            middleCircleContainerView.centerXAnchor.constraint(equalTo: bottomCircleContainterView.centerXAnchor),
            middleCircleContainerView.centerYAnchor.constraint(equalTo: bottomCircleContainterView.centerYAnchor),
            middleCircleContainerView.heightAnchor.constraint(equalTo: bottomCircleContainterView.heightAnchor, multiplier: 0.75),
            middleCircleContainerView.widthAnchor.constraint(equalTo: middleCircleContainerView.heightAnchor),
            
            topCircleContainerView.centerXAnchor.constraint(equalTo: middleCircleContainerView.centerXAnchor),
            topCircleContainerView.centerYAnchor.constraint(equalTo: middleCircleContainerView.centerYAnchor),
            topCircleContainerView.heightAnchor.constraint(equalTo: middleCircleContainerView.heightAnchor, multiplier: 0.85),
            topCircleContainerView.widthAnchor.constraint(equalTo: topCircleContainerView.heightAnchor)
        ])
    }
    
    func setupScoreLabels() {
        let stackView = UIStackView(arrangedSubviews: [scoreTitleLabel,
                                                       scoreNumLabel,
                                                       pointTitleLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        topCircleContainerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topCircleContainerView.topAnchor, constant: MQOffset.offset8),
            stackView.leadingAnchor.constraint(equalTo: topCircleContainerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: topCircleContainerView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: topCircleContainerView.bottomAnchor, constant: -MQOffset.offset8)
        ])
    }
    
    func setupCongratulationForm() {
        congratulationFormStackView.addArrangedSubview(congratulationTitleLabel)
        congratulationFormStackView.addArrangedSubview(descriptionSubtitleLabel)

        congratulationFormStackView.axis = .vertical
        congratulationFormStackView.distribution = .fillProportionally
        congratulationFormStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mainContainerView.addSubview(congratulationFormStackView)
        
        NSLayoutConstraint.activate([
            congratulationFormStackView.topAnchor.constraint(equalTo: bottomCircleContainterView.bottomAnchor, constant: MQOffset.offset16),
            congratulationFormStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MQOffset.offset36),
            congratulationFormStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MQOffset.offset36),
            congratulationFormStackView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    func setupFireworkAnimation() {
        mainContainerView.addSubview(fireworkAnimationView)
        
        NSLayoutConstraint.activate([
            fireworkAnimationView.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            fireworkAnimationView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            fireworkAnimationView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            fireworkAnimationView.bottomAnchor.constraint(equalTo: congratulationFormStackView.bottomAnchor)
        ])
    }
    
    func setupResultForm() {
        let bestScoreStackView = UIStackView(arrangedSubviews: [bestScoreTitleLabel,
                                                                bestScoreNumLabel])
        bestScoreStackView.axis = .vertical
        
        let totalTimeStackView = UIStackView(arrangedSubviews: [totalTimeTitleLabel,
                                                                totalTimeNumLabel])
        totalTimeStackView.axis = .vertical
        
        let completionStackView = UIStackView(arrangedSubviews: [completionTitleLabel,
                                                                 completionNumLabel])
        completionStackView.axis = .vertical
        
        let errorsStackView = UIStackView(arrangedSubviews: [errorsTitleLabel,
                                                             errorsNumLabel])
        errorsStackView.axis = .vertical
        
        let leftStackView = UIStackView(arrangedSubviews: [bestScoreStackView,
                                                           totalTimeStackView])
        leftStackView.axis = .vertical
        leftStackView.spacing = 28
        
        let rightStackView = UIStackView(arrangedSubviews: [completionStackView,
                                                            errorsStackView])
        rightStackView.axis = .vertical
        rightStackView.spacing = 28
        
        let mainStackView = UIStackView(arrangedSubviews: [leftStackView,
                                                           rightStackView])
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mainContainerView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: congratulationFormStackView.bottomAnchor, constant: MQOffset.offset8),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupResultsText() {
        scoreNumLabel.text = "72"
        descriptionSubtitleLabel.text = "Даниил, ты решил все задания на сложение!"
        bestScoreNumLabel.text = "69 очков"
        totalTimeNumLabel.text = "7:56 мин"
        completionNumLabel.text = "100%"
        errorsNumLabel.text = "3"
    }
    
    func setupViewsCornerRadius() {
        mainContainerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        mainContainerView.layer.cornerRadius = 30
        
        bottomCircleContainterView.layoutIfNeeded()
        middleCircleContainerView.layoutIfNeeded()
        topCircleContainerView.layoutIfNeeded()
        
        bottomCircleContainterView.layer.cornerRadius = bottomCircleContainterView.frame.width / 2
        middleCircleContainerView.layer.cornerRadius = middleCircleContainerView.frame.width / 2
        topCircleContainerView.layer.cornerRadius = topCircleContainerView.frame.width / 2
    }
}
