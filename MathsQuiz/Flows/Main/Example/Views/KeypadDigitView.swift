//
//  KeypadButton.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 02.01.2022.
//

import UIKit

class KeypadDigitView: UIView {
    
    var digit: Int?
    
    private(set) lazy var digitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = MQFont.systemFont24
        label.textColor = .black
        return label
    }()
    
    init(digit: String) {
        self.digit = Int(digit)
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        if let digit = digit {
            self.digitLabel.text = "\(digit)"
            
            self.addSubview(digitLabel)
            
            NSLayoutConstraint.activate([
                digitLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                digitLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.saveGState()
        defer { context.restoreGState() }
        
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

        context.addPath(clipPath.cgPath)
        context.setFillColor(UIColor.systemGray4.cgColor)
        context.closePath()
        context.fillPath()
    }
}
