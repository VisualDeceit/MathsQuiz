//
//  HomeCollectionViewData.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 17.12.2021.
//

import UIKit

struct HomeCollectionViewData {
    var name: String
    var color: UIColor
    var levelCount: String
    var userProgressValue: Double?
    
    static var levelsCount = [18, 17, 23, 22, 10]
    
    static var data: [HomeCollectionViewData] = [HomeCollectionViewData(name: "Сложение",
                                                                        color: MQColor.lavenderLight,
                                                                        levelCount: "18 уровней"),
                                                 HomeCollectionViewData(name: "Вычитание",
                                                                        color: MQColor.pictonBlueLight,
                                                                        levelCount: "17 уровней"),
                                                 HomeCollectionViewData(name: "Умножение",
                                                                        color: MQColor.moonstoneBlueLight,
                                                                        levelCount: "23 уровня"),
                                                 HomeCollectionViewData(name: "Деление",
                                                                        color: MQColor.jasperOrangeLight,
                                                                        levelCount: "22 уровня"),
                                                 HomeCollectionViewData(name: "Выражения",
                                                                        color: MQColor.candyPinkLight,
                                                                        levelCount: "10 уровней")]
}
