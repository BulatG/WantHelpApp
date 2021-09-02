//
//  SceneDelegate.swift
//  Хочу помочь
//
//  Created by Булат on 14.04.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "tabBarViewController") as? TabBarViewController
        let mainVC = viewController?.viewControllers?[2]
        viewController!.selectedViewController = mainVC
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }
}

