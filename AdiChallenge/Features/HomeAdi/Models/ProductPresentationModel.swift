//
//  ProductPresentationModel.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 26/03/2021.
//

import Foundation

struct ProductPresentationModel {
    let id: String
    let name: String
    let image: String
    let price: String
    let description: String
}

extension ProductPresentationModel {
    
    init(product: Product) {
        id = product.id
        name = product.name
        image = product.imgURL
        description = product.productDescription
        price = "\(product.price)" + product.currency
    }
}


struct ProductReview {
    let desc: String
    let rating: Int
}

extension ProductReview {
    
    init(review: Review) {
        desc = review.text
        rating = review.rating
    }
}


struct AdiAlertModel {
    let title: String
    let message: String
}
