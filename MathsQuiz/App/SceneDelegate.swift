//
//  SceneDelegate.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 13.12.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var rootController: UINavigationController? {
        return self.window?.rootViewController as? UINavigationController
    }
    
    private lazy var appCoordinator: Coordinator? = self.makeCoordinator()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UserAccountViewController()
        //window?.rootViewController = UINavigationController()
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        UserDefaultsWrapper.uid = nil
        //appCoordinator?.start()
    }
    
    private func makeCoordinator() -> Coordinator? {
        if let rootController = self.rootController {
            return  AppCoordinator(router: RouterImp(rootController: rootController), coordinatorFactory: CoordinatorFactoryImp())
        } else {
            return nil
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
