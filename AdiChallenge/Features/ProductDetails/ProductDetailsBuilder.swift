//
//  ProductDetailsBuilder.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import UIKit

public struct ProductDetailsBuilder {

    public static func viewController(product: Product, coordinator: Coordinator) -> UIViewController {
        
        return ProductDetailsViewController(viewModel: ProductDetailsViewModel(product: product, coordinator: coordinator))
    }
}
