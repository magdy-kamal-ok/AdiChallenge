//
//  ProductDetailsBuilder.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import UIKit

public struct ProductDetailsBuilder {

    public static func viewController(product: Product, coordinator: Coordinator) -> UIViewController {
        let postReview = PostReview(requestHandler: RequestFactory(url: String(format: Constants.reviewsApiURL, product.id), method: .post))
        let viewModel = ProductDetailsViewModel(product: product, coordinator: coordinator, postReview: postReview)
        return ProductDetailsViewController(viewModel: viewModel)
    }
}
