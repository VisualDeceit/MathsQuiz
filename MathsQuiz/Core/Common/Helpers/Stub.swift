//
//  HomeCollectionViewData.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 17.12.2021.
//

import UIKit

struct Stub {
    static var activities: [Activity] = [
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
