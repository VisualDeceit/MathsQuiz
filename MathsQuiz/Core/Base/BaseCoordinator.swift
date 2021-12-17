//
//  BaseCoordinator.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 16.12.2021.
//

import UIKit

class BaseCoordinator: Coordinator {
  
  var childCoordinators: [Coordinator] = []
  
  func start() {}
  
  func addDependency(_ coordinator: Coordinator) {
    guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
    childCoordinators.append(coordinator)
  }
  
  func removeDependency(_ coordinator: Coordinator?) {
    guard
      childCoordinators.isEmpty == false,
      let coordinator = coordinator
      else { return }
    
    if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
        coordinator.childCoordinators
            .filter({ $0 !== coordinator })
            .forEach({ coordinator.removeDependency($0) })
    }
    for (index, element) in childCoordinators.enumerated() where element === coordinator {
        childCoordinators.remove(at: index)
        break
    }
  }
}
