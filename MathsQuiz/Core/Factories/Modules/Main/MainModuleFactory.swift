//
//  MainModuleFactory.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 19.12.2021.
//

import Foundation

protocol MainModuleFactory {
    func makeHomeView() -> HomeViewInput & Presentable
    func makeUserProfileView() -> UserProfileViewInput & Presentable
    func makeUserProfileDetailView() -> UserProfileDetailViewInput & Presentable
    func makeLevelsView(activity: ActivityType) -> LevelsViewInput & Presentable
    func makePasswordChangeView() -> PasswordChangeViewInput & Presentable
}
