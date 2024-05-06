//
//  AppDelegate.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/27/24.
//

import UIKit
import RouraFoundation

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
                Log.info("App Did Launch!")

        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self

        return sceneConfig
    }
}
