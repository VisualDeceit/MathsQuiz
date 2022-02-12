//
//  ScoreViewController.swift
//  MathsQuiz
//
//  Created by Karakhanyan Tigran on 12.01.2022.
//

import UIKit
import SnapKit
import Lottie

class ScoreViewController: UIViewController, ScoreViewInput {
    
    var presenter: (ScorePresenterOutput & ScoreViewOutput)?
    
    private let mainContainerView = UIView()
    private let bottomCircleContainerView = UIView()
    private let middleCircleContainerView = UIView()
    private let topCircleContainerView = UIView()
    private var congratulationFormStackView = UIStackView()
    private var bottomStackView = UIStackView()
    
    private let closeButton = MQPlainButton(title: "Закрыть")
    
    private let fireworkAnimationView: AnimationView = {
        let view = AnimationView()
        let path = Bundle.main.path(forResource: "fireworkAnimation", ofType: "json") ?? ""
        view.animation = Animation.filepath(path)
        return view
    }()
    
    private let scoreTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Счет"
        label.font = MQFont.boldSystemFont18
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let scoreNumLabel: UILabel = {
        let label = UILabel()
        label.font = MQFont.systemFont48
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let pointTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "очка"
        label.font = MQFont.systemFont18
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let congratulationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = MQFont.boldSystemFont24
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let descriptionSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = MQFont.systemFont16
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let bestScoreTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Лучший результат"
        label.font = MQFont.boldSystemFont14
        label.textAlignment = .center
        return label
    }()
    
    private let bestScoreNumLabel: UILabel = {
        let label = UILabel()
        label.font = MQFont.boldSystemFont14
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let totalTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Общее время"
        label.font = MQFont.boldSystemFont14
        label.textAlignment = .center
        return label
    }()
    
    private let totalTimeNumLabel: UILabel = {
        let label = UILabel()
        label.font = MQFont.boldSystemFont14
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let completionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Завершено"
        label.font = MQFont.boldSystemFont14
        label.textAlignment = .center
        return label
    }()
    
    private let completionNumLabel: UILabel = {
        let label = UILabel()
        label.font = MQFont.boldSystemFont14
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let errorsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ошибок"
        label.font = MQFont.boldSystemFont14
        label.textAlignment = .center
        return label
    }()
    
    private let errorsNumLabel: UILabel = {
        let label = UILabel()
        label.font = MQFont.boldSystemFont14
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let resetLevelsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "resetLevels"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    private let homeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "home"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "share"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if presenter?.scoreViewType == .some(.win) {
            fireworkAnimationView.play { _ in
                self.fireworkAnimationView.stop()
                self.fireworkAnimationView.removeFromSuperview()
            }
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
        setupTargets()
    }
    
    func setupCloseButton() {
        closeButton.setTitleColor(presenter?.activityType.color, for: .highlighted)
        closeButton.setTitleColor(presenter?.activityType.highlightedСolor, for: .normal)
        
        mainContainerView.addSubview(closeButton)
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(mainContainerView).offset(MQOffset.offset8)
            make.trailing.equalTo(mainContainerView).inset(MQOffset.offset8)
        }
    }

    func setupBottomButtons() {
        bottomStackView.addArrangedSubview(resetLevelsButton)
        bottomStackView.addArrangedSubview(homeButton)
        bottomStackView.addArrangedSubview(shareButton)

        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .fillEqually
        bottomStackView.spacing = 20
        
        view.addSubview(bottomStackView)
        
        resetLevelsButton.snp.makeConstraints { make in
            make.height.width.equalTo(MQOffset.offset64)
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(MQOffset.offset16)
            make.centerX.equalTo(view)
        }
    }
    
    func setupMainContainerView() {
        mainContainerView.backgroundColor = presenter?.activityType.color
        
        view.addSubview(mainContainerView)
        
        mainContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomStackView.snp.top).inset(-MQOffset.offset20)
        }
    }
    
    func setupCircleContainerViews() {
        let circleContainerColor = presenter?.activityType.highlightedСolor ?? .black
        let middleLighterColor = circleContainerColor.lighter(by: 20)
        let topLighterColor = circleContainerColor.lighter(by: 50)
        
        bottomCircleContainerView.backgroundColor = circleContainerColor
        middleCircleContainerView.backgroundColor = middleLighterColor
        topCircleContainerView.backgroundColor = topLighterColor
        
        mainContainerView.addSubview(bottomCircleContainerView)
        bottomCircleContainerView.addSubview(middleCircleContainerView)
        middleCircleContainerView.addSubview(topCircleContainerView)
        
        bottomCircleContainerView.snp.makeConstraints { make in
            make.top.equalTo(mainContainerView).offset(MQOffset.offset40)
            make.centerX.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.27)
            make.width.equalTo(bottomCircleContainerView.snp.height)
        }
        
        middleCircleContainerView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(bottomCircleContainerView)
            make.height.equalTo(bottomCircleContainerView.snp.height).multipliedBy(0.75)
            make.width.equalTo(middleCircleContainerView.snp.height)
        }
        
        topCircleContainerView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(middleCircleContainerView)
            make.height.equalTo(middleCircleContainerView).multipliedBy(0.85)
            make.width.equalTo(topCircleContainerView.snp.height)
        }
    }
    
    func setupScoreLabels() {
        scoreTitleLabel.textColor = presenter?.activityType.highlightedСolor
        pointTitleLabel.textColor = presenter?.activityType.highlightedСolor
        bestScoreTitleLabel.textColor = presenter?.activityType.highlightedСolor
        totalTimeTitleLabel.textColor = presenter?.activityType.highlightedСolor
        errorsTitleLabel.textColor = presenter?.activityType.highlightedСolor
        completionTitleLabel.textColor = presenter?.activityType.highlightedСolor
        
        let stackView = UIStackView(arrangedSubviews: [scoreTitleLabel,
                                                       scoreNumLabel,
                                                       pointTitleLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        topCircleContainerView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(topCircleContainerView).offset(MQOffset.offset8)
            make.leading.trailing.equalTo(topCircleContainerView)
            make.bottom.equalTo(topCircleContainerView).inset(MQOffset.offset8)
        }
    }
    
    func setupCongratulationForm() {
        congratulationFormStackView.addArrangedSubview(congratulationTitleLabel)
        congratulationFormStackView.addArrangedSubview(descriptionSubtitleLabel)

        congratulationFormStackView.axis = .vertical
        congratulationFormStackView.distribution = .fillProportionally
        
        mainContainerView.addSubview(congratulationFormStackView)
        
        congratulationFormStackView.snp.makeConstraints { make in
            make.top.equalTo(bottomCircleContainerView.snp.bottom).offset(MQOffset.offset16)
            make.leading.equalTo(view).offset(MQOffset.offset36)
            make.trailing.equalTo(view).inset(MQOffset.offset36)
            make.height.equalTo(80)
        }
    }

    func setupFireworkAnimation() {
        if presenter?.scoreViewType == .some(.lose) { return }
        
        mainContainerView.addSubview(fireworkAnimationView)
        
        fireworkAnimationView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(mainContainerView)
            make.bottom.equalTo(congratulationFormStackView)
        }
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
        
        mainContainerView.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(congratulationFormStackView.snp.bottom).offset(MQOffset.offset8)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(100)
        }
    }
    
    func setupResultsText() {
        switch presenter?.scoreViewType {
        case .win:
            congratulationTitleLabel.text = "Поздравляем!"
            descriptionSubtitleLabel.text = "Ты решил все задания на \(presenter?.activityType.rawValue.lowercased() ?? "")"
        case .lose:
            congratulationTitleLabel.text = "К сожалению, ты проиграл!"
            descriptionSubtitleLabel.text = "Попробуй еще раз"
        case .none:
            break
        }
        scoreNumLabel.text = "\(presenter?.score?.value ?? 0)"
        errorsNumLabel.text = "\(presenter?.score?.attempts ?? 0)"
    }
    
    func setupViewsCornerRadius() {
        mainContainerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        mainContainerView.layer.cornerRadius = 30
        
        bottomCircleContainerView.layoutIfNeeded()
        middleCircleContainerView.layoutIfNeeded()
        topCircleContainerView.layoutIfNeeded()
        
        bottomCircleContainerView.layer.cornerRadius = bottomCircleContainerView.frame.width / 2
        middleCircleContainerView.layer.cornerRadius = middleCircleContainerView.frame.width / 2
        topCircleContainerView.layer.cornerRadius = topCircleContainerView.frame.width / 2
    }
}

// MARK: - Setup targets
private extension ScoreViewController {
    func setupTargets() {
        closeButton.addTarget(self,
                              action: #selector(closeButtonTapped),
                              for: .touchUpInside)
        resetLevelsButton.addTarget(self,
                                    action: #selector(resetLevelsButtonTapped),
                                    for: .touchUpInside)
        homeButton.addTarget(self,
                             action: #selector(homeButtonTapped),
                             for: .touchUpInside)
        shareButton.addTarget(self,
                              action: #selector(shareButtonTapped),
                              for: .touchUpInside)
    }
    
    @objc func closeButtonTapped() {
        presenter?.closeButtonDidTapped()
    }
    
    @objc func resetLevelsButtonTapped() {
        presenter?.resetButtonDidTapped()
    }
    
    @objc func homeButtonTapped() {
        presenter?.homeButtonDidTapped()
    }
    
    @objc func shareButtonTapped() {
        let renderer = UIGraphicsImageRenderer(bounds: mainContainerView.bounds)
        let image = renderer.pngData(actions: {rendererContext in
            closeButton.isHidden = true
            mainContainerView.layer.render(in: rendererContext.cgContext)
            closeButton.isHidden = false
        })
        presenter?.sharedObjectsPrepared(objects: [image])
    }
}

// MARK: - ScoreViewInput
extension ScoreViewController {
    func displayStatistics(totalScore: String, totalTime: String, completion: String) {
        bestScoreNumLabel.text = totalScore
        totalTimeNumLabel.text = totalTime
        completionNumLabel.text = completion
    }
}
