//
//  ExampleViewController.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 02.01.2022.
//

import UIKit

class ExampleViewController: UIViewController, ExampleViewInput {
    
    var presenter: (ExamplePresenterOutput & ExampleViewOutput)?
    var relativeLocation = CGPoint()
    var isDigitCaptured = false
    
    private let exampleWorkspaceView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let topKeypadStack: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.spacing = 0
        sv.contentMode = .scaleToFill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let bottomKeypadStack: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.spacing = 0
        sv.contentMode = .scaleToFill
        sv.translatesAutoresizingMaskIntoConstraints = false
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
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let timerLabel: UILabel = {
       let label = UILabel()
        label.text = "00:00"
        label.font = MQFont.timerFont
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let panGestureRecognizer = UIPanGestureRecognizer()
    
    private let checkButton = MQStandardButton(title: "Проверить")
    
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
        
        NSLayoutConstraint.activate([
            exampleWorkspaceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            exampleWorkspaceView.bottomAnchor.constraint(equalTo: topKeypadStack.topAnchor),
            exampleWorkspaceView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            exampleWorkspaceView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
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
        for i in 0...9 {
            keypad.append(KeypadDigitView(digit: i))
        }
        
        Array(keypad[1...5]).forEach { topKeypadStack.addArrangedSubview($0) }
        Array(keypad[6...9]).forEach { bottomKeypadStack.addArrangedSubview($0) }
        bottomKeypadStack.addArrangedSubview(keypad[0])
        
        view.addSubview(topKeypadStack)
        view.addSubview(bottomKeypadStack)
        
        NSLayoutConstraint.activate([
            topKeypadStack.heightAnchor.constraint(equalToConstant: Keypad.buttonSize),
            topKeypadStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: Indent.single),
            topKeypadStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -Indent.single)
        ])
        
        NSLayoutConstraint.activate([
            bottomKeypadStack.heightAnchor.constraint(equalToConstant: Keypad.buttonSize),
            bottomKeypadStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                       constant: Indent.single),
            bottomKeypadStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                        constant: -Indent.single),
            bottomKeypadStack.topAnchor.constraint(equalTo: topKeypadStack.bottomAnchor,
                                                   constant: Indent.single)
        ])
    }
    
    func setupButtons() {
        view.addSubview(checkButton)
        NSLayoutConstraint.activate([
            checkButton.widthAnchor.constraint(equalToConstant: Keypad.checkButtonWidth),
            checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkButton.topAnchor.constraint(equalTo: bottomKeypadStack.bottomAnchor,
                                             constant: Indent.single),
            checkButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                constant: -Indent.single)
        ])
    }
    
    func setupTargets() {
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    @objc func checkButtonTapped() {
        presenter?.viewDidCheckButtonTap()
    }
    
    func setupUserStateBar() {
        view.addSubview(attemptsStackView)
        NSLayoutConstraint.activate([
            attemptsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                       constant: Indent.single),
            attemptsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                   constant: Indent.single),
            attemptsStackView.widthAnchor.constraint(equalToConstant: ExampleView.attemptsWidth)
        ])
        
        view.addSubview(timerLabel)
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: Indent.single),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: -Indent.single)
        ])
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
        
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: exampleWorkspaceView.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: exampleWorkspaceView.centerYAnchor)
        ])
    }
    
    func refreshAttemptsView(with attempts: Int) {
        attemptsStackView.subviews.forEach { (view) in view.removeFromSuperview() }
        for i in 1...3 {
            let image = UIImageView()
            if i <= attempts {
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
}
