//
//  Product.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import Foundation

// MARK: - Product
public struct Product: Codable {
    let currency: String
    let price: Int
    let id, name, productDescription: String
    let imgURL: String
    var reviews: [Review]

    enum CodingKeys: String, CodingKey {
        case currency, price, id, name
        case productDescription = "description"
        case imgURL = "imgUrl"
        case reviews
    }
}

// MARK: - Review
struct Review: Codable {
    let productID, locale: String
    let rating: Int
    let text: String

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case locale, rating, text
    }

//    init(productID: String, locale: String, rating: Int, text: String) {
//        self.productID = productID
//        self.locale = locale
//        self.rating = rating
//        self.text = text
//    }
}
