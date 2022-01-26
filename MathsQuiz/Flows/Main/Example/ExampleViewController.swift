//
//  ExampleViewController.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 02.01.2022.
//

import UIKit
import SnapKit

class ExampleViewController: UIViewController, ExampleViewInput {
    
    var presenter: (ExamplePresenterOutput & ExampleViewOutput)?
    var relativeLocation = CGPoint()
    var isDigitCaptured = false
    var checkButtonTitle = CheckButtonTitle.check
    
    private let exampleWorkspaceView = UIView()
    
    private let topKeypadStack: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.spacing = 0
        sv.contentMode = .scaleToFill
        return sv
    }()
    
    private let bottomKeypadStack: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.spacing = 0
        sv.contentMode = .scaleToFill
        return sv
    }()
    
    private let keypadDraggableLabel: UILabel = {
        let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)))
        label.isHidden = true
        label.font = MQFont.keypadFont
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let attemptsStackView: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.spacing = 1
        return sv
    }()
    
    private let timerLabel: UILabel = {
       let label = UILabel()
        label.text = "00:00"
        label.font = MQFont.timerFont
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let panGestureRecognizer = UIPanGestureRecognizer()
    
    private let checkButton = MQStandardButton(title: CheckButtonTitle.check.rawValue)
    
    private var keypad = [KeypadDigitView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
        presenter?.viewDidLoad()
    }
}

private extension ExampleViewController {
    
    func setupViews() {
        view.backgroundColor = MQColor.background
        setupKeypad()
        setupButtons()
        view.addSubview(keypadDraggableLabel)
        setupGestureRecognizers()
        setupWorkspace()
        setupTargets()
        setupUserStateBar()
    }
    
    func setupWorkspace() {
        view.addSubview(exampleWorkspaceView)
        view.sendSubviewToBack(exampleWorkspaceView)
        
        exampleWorkspaceView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(topKeypadStack.snp.top)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func setupNavigationBar() {
        title = "Пример"
        navigationController?.navigationBar.tintColor = MQColor.ubeDefault
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func setupKeypad() {
        for index in 0...9 {
            keypad.append(KeypadDigitView(digit: index))
        }
        
        Array(keypad[1...5]).forEach { topKeypadStack.addArrangedSubview($0) }
        Array(keypad[6...9]).forEach { bottomKeypadStack.addArrangedSubview($0) }
        bottomKeypadStack.addArrangedSubview(keypad[0])
        
        view.addSubview(topKeypadStack)
        view.addSubview(bottomKeypadStack)
        
        topKeypadStack.snp.makeConstraints { make in
            make.height.equalTo(Keypad.buttonSize)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(MQOffset.offset8)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(MQOffset.offset8)
        }
        
        bottomKeypadStack.snp.makeConstraints { make in
            make.height.equalTo(Keypad.buttonSize)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(MQOffset.offset8)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(MQOffset.offset8)
            make.top.equalTo(topKeypadStack.snp.bottom).offset(MQOffset.offset8)
        }
    }
    
    func setupButtons() {
        view.addSubview(checkButton)
        
        checkButton.snp.makeConstraints { make in
            make.width.equalTo(Keypad.checkButtonWidth)
            make.centerX.equalToSuperview()
            make.top.equalTo(bottomKeypadStack.snp.bottom).offset(MQOffset.offset8)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(MQOffset.offset8)
        }
    }
    
    func setupTargets() {
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    @objc func checkButtonTapped() {
        presenter?.viewDidCheckButtonTap(with: checkButtonTitle)
    }
    
    func setupUserStateBar() {
        view.addSubview(attemptsStackView)
        view.addSubview(timerLabel)
        
        attemptsStackView.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(MQOffset.offset8)
            make.width.equalTo(ExampleView.attemptsWidth
            )
        }
        
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(MQOffset.offset8)
            make.trailing.equalTo(view).inset(MQOffset.offset8)
        }
    }
}

// MARK: - UIPanGestureRecognizer
private extension ExampleViewController {
    
    func setupGestureRecognizers() {
        view.addGestureRecognizer(panGestureRecognizer)
        panGestureRecognizer.addTarget(self, action: #selector(panGesture(sender:)))
    }
    
    @objc func panGesture(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            relativeLocation = sender.location(in: self.view)
            for button in keypad {
                let frame = button.convert(button.bounds, to: view)
                if frame.contains(relativeLocation) {
                    isDigitCaptured = true
                    relativeLocation.y -= 25
                    keypadDraggableLabel.text = "\(button.digit)"
                    keypadDraggableLabel.center = relativeLocation
                    keypadDraggableLabel.isHidden = false
                    break
                }
            }
        case .changed:
            let translation = sender.translation(in: sender.view)
            let newCenter = CGPoint(x: relativeLocation.x + translation.x,
                                    y: relativeLocation.y + translation.y)
            keypadDraggableLabel.center = newCenter
        case .ended:
            keypadDraggableLabel.isHidden = true
            if let targetDigitView = self.view.hitTest(keypadDraggableLabel.center,
                                                       with: .none) as? ExampleDigitView,
               isDigitCaptured {
                let value = Int(keypadDraggableLabel.text ?? "") ?? 0
                let index = targetDigitView.index
                targetDigitView.setDigit("\(value)")
                presenter?.viewDidSetDigit(value: value, at: index)
            }
            isDigitCaptured = false
        case .cancelled, .failed:
            keypadDraggableLabel.isHidden = true
            isDigitCaptured = false
        default:
            break
        }
    }
}

// MARK: - ExampleViewInput
extension ExampleViewController {
    
    func displayExample(view: UIView) {
        exampleWorkspaceView.subviews.forEach { (view) in view.removeFromSuperview() }
        exampleWorkspaceView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(exampleWorkspaceView)
        }
    }
    
    func refreshAttemptsView(with attempts: Int) {
        attemptsStackView.subviews.forEach { (view) in view.removeFromSuperview() }
        for index in 1...3 {
            let image = UIImageView()
            if index <= attempts {
                image.image = UIImage(systemName: "star.fill")
            } else {
                image.image = UIImage(systemName: "star")
            }
            image.contentMode = .scaleAspectFit
            image.tintColor = presenter?.activity.highlightedСolor
            image.transform = .init(rotationAngle: 0.26)
            image.heightAnchor.constraint(equalToConstant: 26).isActive = true
            attemptsStackView.addArrangedSubview(image)
        }
        attemptsStackView.setNeedsLayout()
    }
    
    func refreshTimerView(with time: String) {
        timerLabel.text = time
    }
    
    func changeCheckButton(title: CheckButtonTitle) {
        checkButtonTitle = title
        checkButton.setTitle(checkButtonTitle.rawValue, for: .normal)
        if title == .transition {
            exampleWorkspaceView.allSubViewsOf(type: ExampleDigitView.self)
                .filter { $0.type == .result }
                .forEach { $0.setColor(for: true) }
        }
    }
}
