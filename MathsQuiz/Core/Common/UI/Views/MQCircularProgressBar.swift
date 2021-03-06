//
//  CircularProgressBarView.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 18.12.2021.
//

import UIKit

class MQCircularProgressBar: UIView {
    
    private let circleLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    
    private let startPoint = CGFloat(-Double.pi / 2)
    private let endPoint = CGFloat(3 * Double.pi / 2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularPath()
    }
    
    func createCircularPath() {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: 12.5,
                                                           y: 12.5),
                                        radius: 12,
                                        startAngle: startPoint,
                                        endAngle: endPoint,
                                        clockwise: true)
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.strokeEnd = 1
        circleLayer.lineWidth = 3.0
        circleLayer.strokeColor = UIColor(rgb: 0xC4C4C4).cgColor
        layer.addSublayer(circleLayer)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 3.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.clear.cgColor
        layer.addSublayer(progressLayer)
    }

    func progressTo(value: Double) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        progressLayer.strokeEnd = CGFloat(value)
        CATransaction.commit()
    }
    
    func setStrokeColor(_ color: UIColor) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        progressLayer.strokeColor = color.cgColor
        CATransaction.commit()
    }
}
