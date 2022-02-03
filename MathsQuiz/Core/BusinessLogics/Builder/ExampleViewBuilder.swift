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
        verticalStackView.spacing = 4
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .trailing
        verticalStackView.distribution = .equalSpacing
    }
    
    private func makeView() -> UIStackView {
        let sv = UIStackView()
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
        // let carryView = ExampleCarryView(carry: "0")
        
        view.addSubview(digitView)
        
        horizontalStackView?.addArrangedSubview(view)
        
//        if digit.carry != 0 {
//            let carryFrameSize: CGFloat = 25
//
//            view.addSubview(carryView)
//
//            carryView.snp.makeConstraints { make in
//                make.width.height.equalTo(carryFrameSize)
//                make.centerX.equalTo(view.snp.trailing).inset(carryFrameSize / 2)
//                make.top.equalTo(view)
//            }
//
//            digitView.snp.makeConstraints { make in
//                make.width.equalTo(50)
//                make.height.equalTo(70)
//                make.centerX.bottom.equalTo(view)
//            }
//
//            view.snp.makeConstraints { make in
//                make.width.equalTo(50)
//                make.height.equalTo(70 + carryFrameSize)
//            }
//        } else {
            digitView.snp.makeConstraints { make in
                make.width.equalTo(50)
                make.height.equalTo(70)
                make.centerX.bottom.equalTo(view)
            }
            
            view.snp.makeConstraints { make in
                make.width.equalTo(50)
                make.height.equalTo(70)
            }
//        }
    }

    func addSign(_ sign: ActivityType) {
        let digitView = ExampleDigitView(sign: sign)
        horizontalStackView?.addArrangedSubview(digitView)
        
        digitView.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(70)
        }
    }
    
    func addSeparator(for digits: Int) {
        addStackViewAndNil()
        
        let separator = UIView()
        self.verticalStackView.addArrangedSubview(separator)
        separator.backgroundColor = .systemGray4
 
        separator.snp.makeConstraints { make in
            make.width.equalTo(CGFloat(54 * digits))
            make.height.equalTo(4)
        }
    }
    
    func build() -> UIStackView {
        addStackViewAndNil()
        return verticalStackView
    }
}
