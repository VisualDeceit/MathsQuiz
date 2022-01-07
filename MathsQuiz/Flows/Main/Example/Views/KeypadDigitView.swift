//
//  KeypadButton.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 02.01.2022.
//

import UIKit

class KeypadDigitView: UIView {
    
    var digit: Int
    
    private(set) lazy var digitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = MQFont.keypadFont
        label.textColor = .black
        return label
    }()
    
    init(digit: Int) {
        self.digit = digit
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        digitLabel.text = "\(digit)"
        addSubview(digitLabel)
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: heightAnchor),
            digitLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            digitLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    override func draw(_ rect: CGRect) {
        let rectWidth = rect.width
        let rectHeight = rect.height
        
        let xf: CGFloat = (self.frame.width - rectWidth) / 2
        let yf: CGFloat = (self.frame.height - rectHeight) / 2
        
        let rect = CGRect(x: xf, y: yf, width: rectWidth, height: rectHeight)
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = 0.5 * min(rect.width, rect.height)
        
        let clipPath = UIBezierPath(arcCenter: center,
                                    radius: radius,
                                    startAngle: 330 * CGFloat.pi / 180,
                                    endAngle: -30 * CGFloat.pi / 180,
                                    clockwise: false)
        UIColor.systemGray6.setFill()
        clipPath.fill()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.1) {
            self.transform = .init(scaleX: 0.95, y: 0.95)
        }
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        transform = .identity
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        transform = .identity
        super.touchesCancelled(touches, with: event)
    }
}
