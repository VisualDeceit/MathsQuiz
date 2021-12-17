//
//  MainCollectionViewCell.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 17.12.2021.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell, ConfigCell {
    typealias T = String
    
    static var reuseId: String = "MainCollectionViewCell"
    
    func configCell(with value: String) {
        self.backgroundColor = Colors.burntSienna
    }
}

