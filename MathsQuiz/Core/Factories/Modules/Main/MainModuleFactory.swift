//
//  MainModuleFactory.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 19.12.2021.
//

import Foundation

protocol MainModuleFactory {
    func makeHomeView() -> HomeViewInput & Presentable
    func makeUserAccountView() -> UserAccountViewInput & Presentable
    func makeUserDataView() -> UserProfileDetailViewInput & Presentable
    func makeLevelsView() -> LevelsViewInput & Presentable
}
