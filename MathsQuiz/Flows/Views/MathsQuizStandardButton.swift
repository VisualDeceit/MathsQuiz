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
        self.heightAnchor.constraint(equalToConstant: 44).isActive = true    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.transform = .init(scaleX: 0.99, y: 0.99)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
        }
    }
}
