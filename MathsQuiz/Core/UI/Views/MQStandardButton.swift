//
//  MQStandardButton.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 14.12.2021.
//

import UIKit

class MQStandardButton: UIButton {
    
    init(title: String,
         accessibilityIdentifier: String? = nil
    ) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = MQColor.ubeDefault
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(MQColor.ubeHighlighted, for: .highlighted)
        self.layer.cornerRadius = 22
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
