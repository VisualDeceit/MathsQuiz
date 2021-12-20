//
//  MQStandardButton.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 14.12.2021.
//

import UIKit

class MQStandardButton: UIButton {
    
    convenience init(title: String,
                     accessibilityIdentifier: String? = nil) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.backgroundColor = MQColor.ubeDefault
        self.tintColor = MQColor.background
        self.layer.cornerRadius = 22
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}
