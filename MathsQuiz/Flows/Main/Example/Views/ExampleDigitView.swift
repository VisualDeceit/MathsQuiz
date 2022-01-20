//
//  ExampleDigitView.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 07.01.2022.
//

import UIKit
import SnapKit

enum DigitType {
    case common, result
}

class ExampleDigitView: UIView {
    
    let digit: String
    let type: DigitType
    let index: Int
    
    private let rectBorderWidth: CGFloat = 2
    private let rectCornerRadius: CGFloat = 6
    
    private var digitColor: UIColor = .systemGray4
    private var borderColor: UIColor = .systemGray4
    
    private(set) lazy var digitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 80, weight: .regular)
        label.textColor = digitColor
        label.text = digit
        return label
    }()
    
    init(frame: CGRect, digit: String, type: DigitType, index: Int) {
        self.digit = digit
        self.type = type
        self.index = index
        super.init(frame: frame)
        setupView()
    }
    
    convenience init(digit: String, type: DigitType, index: Int) {
        self.init(frame: .zero, digit: digit, type: type, index: index)
    }
    
    convenience init(digit: String, type: DigitType) {
        self.init(frame: .zero, digit: digit, type: type, index: 0)
    }
    
    convenience init(sign: ActivityType) {
        self.init(frame: .zero, digit: sign.sign, type: .common, index: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDigit(_ digit: String) {
        self.digitLabel.text = "\(digit)"
        self.digitLabel.textColor = .label
        borderColor = .systemGray4
        self.setNeedsDisplay()
    }
    
    func setColor(for answer: Bool) {
        if answer {
            digitColor = .green
            borderColor = .green
        } else {
            digitColor = .red
            borderColor = .red
        }
        self.digitLabel.textColor = digitColor
        self.setNeedsDisplay()
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemBackground
        
        if self.type == .result {
            self.digitLabel.textColor = digitColor
        } else {
            self.digitLabel.textColor = .label
        }
        
        self.addSubview(digitLabel)
        
        digitLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    override func draw(_ rect: CGRect) {
        if self.type == .result {
            let rectWidth = rect.width - rectBorderWidth
            let rectHeight = rect.height - rectBorderWidth
            
            let xf: CGFloat = (self.frame.width - rectWidth) / 2
            let yf: CGFloat = (self.frame.height - rectHeight) / 2
            
            let rect = CGRect(x: xf, y: yf, width: rectWidth, height: rectHeight)
            let path = UIBezierPath(roundedRect: rect, cornerRadius: rectCornerRadius)
            
            path.lineWidth = rectBorderWidth
            borderColor.setStroke()
            path.stroke()
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard  self.type == .result, self.bounds.contains(point) else { return nil }
        return self
    }
}
