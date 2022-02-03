//
//  HomeContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 19.12.2021.
//

import Foundation

protocol HomeViewInput: AnyObject {
    var presenter: (HomeViewOutput & HomePresenterOutput)? { get set }
    
    func setGreeting(message: String)
    func setActivities(_ activities: [ActivityViewData]) 
}

protocol HomeViewOutput: AnyObject {
    func viewDidSelectItemAt(_ indexPath: IndexPath)
    func viewDidLoad()
    func viewDidAccountButtonTap()    
}

protocol HomePresenterOutput: AnyObject {
    var onSelectActivity: ((ActivityType) -> Void)? { get set }
    var onAccountButtonTap: (() -> Void)? { get set }
}
