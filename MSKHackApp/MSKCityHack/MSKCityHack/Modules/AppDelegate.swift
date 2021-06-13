//
//  AppDelegate.swift
//  MCHProject
//
//  Created by Савченко Максим Олегович on 12.06.2021.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let welcomeVC = WelcomeAssembly().assembly()
        
        let navigation = UINavigationController(rootViewController: welcomeVC)
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        return true
    }


}

