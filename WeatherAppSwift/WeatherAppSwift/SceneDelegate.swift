//
//  SceneDelegate.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/2.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let firstNavi = UINavigationController(rootViewController: ShowViewController())
        firstNavi.viewControllers.first?.view.backgroundColor = .white
        firstNavi.tabBarItem.title = "天气显示"
        firstNavi.tabBarItem.image = UIImage(named: "home")
            
        let secondNavi = UINavigationController(rootViewController: PersonalViewController())
        secondNavi.viewControllers.first?.view.backgroundColor = .blue
        secondNavi.tabBarItem.title = "个人展示"
        secondNavi.tabBarItem.image = UIImage(named: "personal")
            
        let tabbarViewController = TabBarController()
        tabbarViewController.viewControllers = [firstNavi, secondNavi]
            
        if let windowScene = (scene as? UIWindowScene) {
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = tabbarViewController
            window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

