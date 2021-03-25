//
//  AppDelegate.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import UIKit
import NetworkLayer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        openHomeViewController()
        return true
    }

    func openHomeViewController() {
         window = UIWindow(frame: UIScreen.main.bounds)
         //window?.rootViewController = HomeBuilder.startHomeController()
         window?.makeKeyAndVisible()
    }

}
