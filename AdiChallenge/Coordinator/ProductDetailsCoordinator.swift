//
//  ProductDetailsCoordinator.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import UIKit

class ProductDetailsCoordinator: NSObject, Coordinator {
    
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var product: Product!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    convenience init(navigationController: UINavigationController, product: Product) {
        self.init(navigationController: navigationController)
        self.product = product
    }
    
    func start() {
        let vc = ProductDetailsBuilder.viewController(product: product, coordinator: self)
        if let navbar = navigationController.navigationBar as? AdiNavigationBar {
            navbar.updateCurrentViewController(viewController: vc)
            navbar.setTitleNavigation(title: product.name)
            navbar.addLeftNavigationBarView(viewController: vc)
            navbar.didPressNavBarBack  = { [weak self] in
                guard let self = self else { return }
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.appCoordinator?.childDidFinish(self)
                }
            }
        }
        navigationController.pushViewController(vc, animated: true)
    }

}
