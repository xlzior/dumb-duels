//
//  AppDelegate.swift
//  DumbDuels
//
//  Created by Wen Jun Lye on 8/3/23.
//

import UIKit
import DuelKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let homeView = HomeViewController(nibName: nil, bundle: nil)
        let gameHome = GameHomeView(homeView: homeView)
        navigationController.viewControllers = [homeView]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

}
