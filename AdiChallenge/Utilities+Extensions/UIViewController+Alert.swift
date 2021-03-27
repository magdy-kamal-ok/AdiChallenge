//
//  UIViewController+Alert.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 26/03/2021.
//

import UIKit

extension UIViewController {
    func showAlertOk(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "ok".localized, style: UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
