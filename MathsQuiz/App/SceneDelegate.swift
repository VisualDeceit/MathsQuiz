//
//  SceneDelegate.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 13.12.2021.
//

import UIKit
import SnapKit
import FBSDKCoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var rootController: UINavigationController {
        guard let rootController = self.window?.rootViewController as? UINavigationController  else {
            fatalError("⚠️No root view controller assigned to the window")
        }
        return rootController
    }
    
    private var appCoordinator: Coordinator!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController(rootViewController: ExampleAssembly.build(activity: .addition, level: Level(number: 1, completion: 2)).toPresent()!)
        window?.rootViewController = nav
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
//        appCoordinator = makeCoordinator()
//        appCoordinator.start()
    }
    
    private func makeCoordinator() -> Coordinator {
        return  AppCoordinator(router: RouterImp(rootController: rootController), coordinatorFactory: CoordinatorFactoryImp())
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }

        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
