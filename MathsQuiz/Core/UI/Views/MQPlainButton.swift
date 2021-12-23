//
//  MQPlainButton.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 20.12.2021.
//

import UIKit

class MQPlainButton: UIButton {
    
    init(title: String,
         accessibilityIdentifier: String? = nil
    ) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(MQColor.burntSienna, for: .normal)
        self.setTitleColor(MQColor.burntSiennaLight, for: .highlighted)
        self.titleLabel?.font = MQFont.boldSystemFont14
        self.backgroundColor = MQColor.background
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
