//
//  ExampleViewBuilder.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 07.01.2022.
//

import UIKit

class ExampleViewBuilder {
    
    private var horizontalStackView: UIStackView?
    private var verticalStackView: UIStackView
    
    init() {
        verticalStackView = UIStackView()
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.spacing = 4
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .trailing
        verticalStackView.distribution = .equalSpacing
    }
    
    private func makeView() -> UIStackView {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 4
        sv.axis = .horizontal
        sv.alignment = .bottom
        sv.distribution = .equalSpacing
        return sv
    }
    
    private func addStackViewAndNil() {
        if let horizontalStackView = horizontalStackView {
            verticalStackView.addArrangedSubview(horizontalStackView)
        }
        self.horizontalStackView = nil
    }
    
    func addNewRow() {
        if let horizontalStackView = horizontalStackView {
            verticalStackView.addArrangedSubview(horizontalStackView)
            self.horizontalStackView = makeView()
        } else {
            self.horizontalStackView = makeView()
        }
    }
    
    func addDigit(_ digit: Digit, type: DigitType, index: Int) {
        let view = UIView()
        let digitView = ExampleDigitView(digit: String(digit.value), type: type, index: index)
        let carryView = ExampleCarryView(carry: "0")
        
        view.addSubview(digitView)
        
        horizontalStackView?.addArrangedSubview(view)
        
        if digit.carry != 0 {
            let carryFrameSize: CGFloat = 25
            
            view.addSubview(carryView)
            
            NSLayoutConstraint.activate([
                carryView.widthAnchor.constraint(equalToConstant: carryFrameSize),
                carryView.heightAnchor.constraint(equalToConstant: carryFrameSize),
                carryView.centerXAnchor.constraint(equalTo: view.trailingAnchor, constant: -carryFrameSize / 2),
                carryView.topAnchor.constraint(equalTo: view.topAnchor),
                
                digitView.widthAnchor.constraint(equalToConstant: 50),
                digitView.heightAnchor.constraint(equalToConstant: 70),
                digitView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                digitView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                view.widthAnchor.constraint(equalToConstant: 50),
                view.heightAnchor.constraint(equalToConstant: 70 + carryFrameSize)
            ])
        } else {
            NSLayoutConstraint.activate([
                digitView.widthAnchor.constraint(equalToConstant: 50),
                digitView.heightAnchor.constraint(equalToConstant: 70),
                digitView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                digitView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                view.widthAnchor.constraint(equalToConstant: 50),
                view.heightAnchor.constraint(equalToConstant: 70)
            ])
        }
    }

    func addSign(_ sign: ActivityType) {
        let digitView = ExampleDigitView(sign: sign)
        horizontalStackView?.addArrangedSubview(digitView)
        
        NSLayoutConstraint.activate([
            digitView.widthAnchor.constraint(equalToConstant: 50),
            digitView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    func addSeparator(for digits: Int) {
        addStackViewAndNil()
        
        let separator = UIView()
        self.verticalStackView.addArrangedSubview(separator)
        separator.backgroundColor = .systemGray4
 
        NSLayoutConstraint.activate([
            separator.widthAnchor.constraint(equalToConstant: CGFloat(54 * digits)),
            separator.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    func build() -> UIStackView {
        addStackViewAndNil()
        return verticalStackView
    }
}
