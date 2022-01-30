//
//  MQPlainButton.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 20.12.2021.
//

import UIKit

class MQPlainButton: UIButton {
    
    init(title: String,
         normalColor: UIColor,
         highlightedColor: UIColor,
         accessibilityIdentifier: String? = nil
    ) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(normalColor, for: .normal)
        self.setTitleColor(highlightedColor, for: .highlighted)
        self.titleLabel?.font = MQFont.boldSystemFont14
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(title: String) {
        self.init(title: title,
                  normalColor: MQColor.burntSienna,
                  highlightedColor: MQColor.burntSiennaLight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
