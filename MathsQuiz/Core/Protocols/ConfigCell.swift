//
//  ConfigCell.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 17.12.2021.
//

import Foundation

protocol ConfigCell {
    associatedtype T
    
    static var reuseId: String { get }
    func configure(with value: T)
}
