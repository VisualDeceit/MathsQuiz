//
//  MathsQuizStandardButton.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 14.12.2021.
//

import UIKit

class MathsQuizStandardButton: UIButton {
    
    convenience init(title: String,
                     accessibilityIdentifier: String? = nil) {
        self.init()
        self.setTitle(title, for: .normal)
        self.backgroundColor = Colors.ubeDefault
        self.tintColor = Colors.whiteColor
        self.layer.cornerRadius = 22
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}
