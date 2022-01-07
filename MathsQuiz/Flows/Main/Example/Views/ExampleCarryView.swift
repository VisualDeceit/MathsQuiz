//
//  ExampleCarryView.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 07.01.2022.
//

import UIKit

class ExampleCarryView: UIView {
    
    let carry: String
    
    private let borderWidth: CGFloat = 1
    private var digitColor: UIColor = .systemGray4
    private var borderColor: UIColor = .systemGray4
    
    private(set) lazy var carryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = digitColor
        label.text = carry
        return label
    }()
    
    init(frame: CGRect, carry: String) {
        self.carry = carry
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCarry(_ carry: String) {
        self.carryLabel.text = carry
        self.carryLabel.textColor = .label
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemBackground
        self.addSubview(carryLabel)
        
        NSLayoutConstraint.activate([
            carryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor,
                                                constant: borderWidth / 2),
            carryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor,
                                                constant: -borderWidth / 2)
        ])
    }
    override func draw(_ rect: CGRect) {
        let radius = rect.width / 2 - borderWidth
        let center = CGPoint(x: rect.width - radius - borderWidth / 2,
                             y: radius + borderWidth / 2)
        let path = UIBezierPath(arcCenter: center,
                                radius: radius,
                                startAngle: 330 * CGFloat.pi / 180,
                                endAngle: -30 * CGFloat.pi / 180,
                                clockwise: false)
        
        path.lineWidth = borderWidth
        borderColor.setStroke()
        path.stroke()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard self.bounds.contains(point) else { return nil }
        return self
    }
}
