//
//  MainModuleFactory.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 19.12.2021.
//

import Foundation

protocol MainModuleFactory {
    func makeHomeModule() -> HomeViewInput & Presentable
    func makeUserAccountModule() -> UserAccountViewInput & Presentable
    func makeUserDataModule() -> UserDataViewInput & Presentable
}
