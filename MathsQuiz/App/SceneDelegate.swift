//
//  SceneDelegate.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 13.12.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var rootController: UINavigationController {
      return self.window!.rootViewController as! UINavigationController
    }
    
    private lazy var appCoordinator: Coordinator = self.makeCoordinator()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame:  UIScreen.main.bounds)
//        window?.rootViewController = UserAccountViewController()
        window?.rootViewController = UINavigationController()
        
        appCoordinator.start()
        
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
    }
    
    private func makeCoordinator() -> Coordinator {
        return  AppCoordinator(router: RouterImp(rootController: self.rootController), coordinatorFactory: CoordinatorFactoryImp())
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

