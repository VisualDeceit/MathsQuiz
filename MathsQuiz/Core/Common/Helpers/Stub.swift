//
//  HomeCollectionViewData.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 17.12.2021.
//

import UIKit

struct Stub {
    static var activities: [Activity] = [
        Activity(index: 0,
                 type: .addition,
                 levels: [Level.empty],
                 total: AdditionActivityStrategy.total),
        Activity(index: 1,
                 type: .subtraction,
                 levels: [Level.empty],
                 total: 0),
        Activity(index: 2,
                 type: .multiplication,
                 levels: [Level.empty],
                 total: 0),
        Activity(index: 3,
                 type: .division,
                 levels: [Level.empty],
                 total: 0),
        Activity(index: 5,
                 type: .expression,
                 levels: [Level.empty],
                 total: 0)
    ]
    
    static var levels: [Level] = {
        var array = Array(repeating: -1, count: 20)
            .enumerated()
            .map { Level(number: $0.offset + 1, completion: $0.element) }
      
        array[0].completion = 3
        array[1].completion = 2
        array[2].completion = 1
        array[3].completion = 0
        return array
    }()
}
