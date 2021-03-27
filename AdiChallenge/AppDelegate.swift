//
//  AppDelegate.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        startAppCoordinator()
        return true
    }


}

extension AppDelegate {
    func startAppCoordinator() {
        let navController = UINavigationController.init(navigationBarClass: AdiNavigationBar.self, toolbarClass: nil)
        appCoordinator = AppCoordinator(navigationController: navController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        appCoordinator?.start()
    }
}
