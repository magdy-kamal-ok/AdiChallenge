//
//  AppCoordinator.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import Foundation
import UIKit

class AppCoordinator: NSObject, Coordinator
{
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let child = MainScreenCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        addViewToNavigationStack(coordinator: child)
        child.start()
    }
    
    func showProductDetailsView(with product: Product) {
        let child = ProductDetailsCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        child.product = product
        addViewToNavigationStack(coordinator: child)
        child.start()
    }

    func addViewToNavigationStack(coordinator : Coordinator){
        navigationController.delegate = self
        childCoordinators.append(coordinator)
    }
}
extension AppCoordinator : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
    }
}
extension AppCoordinator {
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}


public class Product {
    var name: String = ""
}
