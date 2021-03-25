//
//  MainScreenCoordinator.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import UIKit

class MainScreenCoordinator: NSObject, Coordinator {
    
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainScreenBuilder.viewController(coordinator: self)
        if let navbar = navigationController.navigationBar as? AdiNavigationBar {
            navbar.addTitleNavigation(viewController: vc, title: "Home Screen")
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showProductDetails(product: Product) {
        parentCoordinator?.showProductDetailsView(with: product)
    }

}
