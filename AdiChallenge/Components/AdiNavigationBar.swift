//
//  AdiNavigationBar.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import UIKit

class AdiNavigationBar: UINavigationBar {

    weak var curentViewController : UIViewController?
    var didPressNavBarBack: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
        
    func updateCurrentViewController(viewController : UIViewController){
        self.curentViewController = viewController
    }
    
    func addTitleNavigation(viewController : UIViewController, title: String) {
        viewController.navigationItem.title = title
    }
    
    func didPressBack() {
        if let navigationController = curentViewController?.navigationController {
            if navigationController.viewControllers.count > 1 {
                navigationController.popViewController(animated: true)
            } else {
                navigationController.dismiss(animated: true, completion: nil)
            }
        }
        didPressNavBarBack?()
    }
    
    @objc private func didPressBackBarButton(sender: UIButton!) {
        didPressBack()
    }
    
    func addLeftNavigationBarView(viewController : UIViewController) {
        self.curentViewController = viewController
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: ""), for: .normal)
        backButton.addTarget(self, action: #selector(didPressBackBarButton), for: .touchUpInside)
        backButton.setTitleColor(.black, for: .normal)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

}
