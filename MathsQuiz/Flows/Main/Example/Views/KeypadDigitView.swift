//
//  KeypadButton.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 02.01.2022.
//

import UIKit
import SnapKit

class KeypadDigitView: UIView {
    
    var digit: Int
    
    private(set) lazy var digitLabel: UILabel = {
        let label = UILabel()
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
        backgroundColor = .clear
        
        digitLabel.text = "\(digit)"
        addSubview(digitLabel)
        
        snp.makeConstraints { (make) in
            make.width.equalTo(snp.height)
        }
        
        digitLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    override func draw(_ rect: CGRect) {        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = 0.5 * min(rect.width, rect.height)
        
        let clipPath = UIBezierPath(arcCenter: center,
                                    radius: radius,
                                    startAngle: 0,
                                    endAngle: 2 * CGFloat.pi,
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
