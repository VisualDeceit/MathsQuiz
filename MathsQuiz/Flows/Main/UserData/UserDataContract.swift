//
//  UserDataContract.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 20.12.2021.
//

import Foundation

protocol UserDataViewInput: AnyObject {
    var presenter: (UserDataViewOutput & UserDataPresenterOutput)? { get set }
}

protocol UserDataViewOutput: AnyObject {
    func viewDidSaveButtonTap()
}

protocol UserDataPresenterOutput: AnyObject {
}
