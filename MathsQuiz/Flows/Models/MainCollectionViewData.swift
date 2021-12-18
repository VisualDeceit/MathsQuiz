//
//  MainCollectionViewData.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 17.12.2021.
//

import UIKit

struct MainCollectionViewData {
    var name: String
    var color: UIColor
    var levelCount: String
    var userProgressValue: Double?
    
    static var data: [MainCollectionViewData] = [MainCollectionViewData(name: "Сложение",
                                                                        color: Colors.lavenderLight,
                                                                        levelCount: "18 уровней"),
                                                 MainCollectionViewData(name: "Вычитание",
                                                                        color: Colors.pictonBlueLight,
                                                                        levelCount: "17 уровней"),
                                                 MainCollectionViewData(name: "Умножение",
                                                                        color: Colors.moonstoneBlueLight,
                                                                        levelCount: "23 уровня"),
                                                 MainCollectionViewData(name: "Деление",
                                                                        color: Colors.jasperOrangeLight,
                                                                        levelCount: "22 уровня"),
                                                 MainCollectionViewData(name: "Выражения",
                                                                        color: Colors.candyPinkLight,
                                                                        levelCount: "10 уровней")]
}
