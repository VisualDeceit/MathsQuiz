//
//  HomeContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 19.12.2021.
//

import Foundation

protocol HomeViewInput: AnyObject {
    var presenter: (HomeViewOutput & HomePresenterOutput)? { get set }
    func reloadCollection(with activities: [Activity])
}

protocol HomeViewOutput: AnyObject {
    func onDidSelectActivity(type: ActivityType)
    func onViewDidLoad()
}

protocol HomePresenterOutput: AnyObject {
    var onSelectActivity: ((ActivityType) -> Void)? { get set }
}
