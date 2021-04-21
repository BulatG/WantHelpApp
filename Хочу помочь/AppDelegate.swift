//
//  AppDelegate.swift
//  Хочу помочь
//
//  Created by Булат on 14.04.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

//  did finish все  знначения для 2 пункта

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // main storybord
        //  тут UINavigationBar.appearance
        _ = UINavigationBarAppearance()
        UINavigationBar.appearance().barTintColor = UIColor(red: 102/255, green: 146/255, blue: 54/255, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "OfficinaSansExtraBoldSCC", size: 21)!, NSAttributedString.Key.foregroundColor: UIColor.white]
//            appearance.backgroundColor = .purple
//            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//
//            UINavigationBar.appearance().tintColor = .white
//            UINavigationBar.appearance().barTintColor = .purple
//            UINavigationBar.appearance().isTranslucent = false
//            UINavigationBar.appearance().standardAppearance = appearance
//            UINavigationBar.appearance().compactAppearance = appearance
//            UINavigationBar.appearance().scrollEdgeAppearance = appearance
//            let navigationTitleFont = UIFont(name: "OfficinaSansExtraBoldSCC", size: 20)!
//            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: navigationTitleFont]
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
}
