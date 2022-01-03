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
            topKeypadStack.heightAnchor.constraint(equalToConstant: Constants.Keypad.buttonSize),
            topKeypadStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: Constants.Indent.single),
            topKeypadStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -Constants.Indent.single)
        ])
        
        NSLayoutConstraint.activate([
            bottomKeypadStack.heightAnchor.constraint(equalToConstant: Constants.Keypad.buttonSize),
            bottomKeypadStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                       constant: Constants.Indent.single),
            bottomKeypadStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                        constant: -Constants.Indent.single),
            bottomKeypadStack.topAnchor.constraint(equalTo: topKeypadStack.bottomAnchor,
                                                   constant: Constants.Indent.single)
        ])
    }
    
    func setupButtons() {
        view.addSubview(checkButton)
        NSLayoutConstraint.activate([
            checkButton.widthAnchor.constraint(equalToConstant: Constants.Keypad.checkButtonWidth),
            checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkButton.topAnchor.constraint(equalTo: bottomKeypadStack.bottomAnchor,
                                             constant: Constants.Indent.single),
            checkButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                constant: -Constants.Indent.single)
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
        case .cancelled, .failed:
            keypadDraggableLabel.isHidden = true
        default:
            break
        }
    }
}
