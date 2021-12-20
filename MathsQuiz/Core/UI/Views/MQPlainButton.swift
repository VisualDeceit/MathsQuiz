//
//  MQPlainButton.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 20.12.2021.
//

import UIKit

class MQPlainButton: UIButton {
    
    convenience init(title: String,
                     accessibilityIdentifier: String? = nil) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(MQColor.burntSienna, for: .normal)
        self.setTitleColor(MQColor.burntSiennaLight, for: .highlighted)
        self.titleLabel?.font = MQFont.boldSystemFont14
        self.backgroundColor = MQColor.background
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
