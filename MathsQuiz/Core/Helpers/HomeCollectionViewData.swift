//
//  HomeCollectionViewData.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 17.12.2021.
//

import UIKit

struct HomeCollectionViewData {

    static var data: [Activity] = [
        Activity(type: .addition,
                 progress: 4,
                 total: 18),
        Activity(type: .subtraction,
                 progress: 10,
                 total: 17),
        Activity(type: .multiplication,
                 progress: 1,
                 total: 23),
        Activity(type: .division,
                 progress: 0,
                 total: 22),
        Activity(type: .expression,
                 progress: 0,
                 total: 10)
    ]
}
