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
    
    private let exampleWorkspaceView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
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
        for i in 0...9 {
            keypad.append(KeypadDigitView(digit: i))
        }
        
        Array(keypad[1...5]).forEach { topKeypadStack.addArrangedSubview($0) }
        Array(keypad[6...9]).forEach { bottomKeypadStack.addArrangedSubview($0) }
        bottomKeypadStack.addArrangedSubview(keypad[0])
        
        view.addSubview(topKeypadStack)
        view.addSubview(bottomKeypadStack)
        
        topKeypadStack.snp.makeConstraints { make in
            make.height.equalTo(Keypad.buttonSize)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(Indent.single)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(Indent.single)
        }
        
        bottomKeypadStack.snp.makeConstraints { make in
            make.height.equalTo(Keypad.buttonSize)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(Indent.single)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(Indent.single)
            make.top.equalTo(topKeypadStack.snp.bottom).offset(Indent.single)
        }
    }
    
    func setupButtons() {
        view.addSubview(checkButton)
        
        checkButton.snp.makeConstraints { make in
            make.width.equalTo(Keypad.checkButtonWidth)
            make.centerX.equalToSuperview()
            make.top.equalTo(bottomKeypadStack.snp.bottom).offset(Indent.single)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Indent.single)
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

// MARK: - ExampleViewInput
extension ExampleViewController {
    
    func displayExample(view: UIView) {
        exampleWorkspaceView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(exampleWorkspaceView)
        }
    }
}
