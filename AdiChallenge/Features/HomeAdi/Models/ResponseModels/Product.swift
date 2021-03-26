//
//  Product.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import Foundation

// MARK: - Product
public class Product: Codable {
    let currency: String
    let price: Int
    let id, name, productDescription: String
    let imgURL: String
    let reviews: [Review]

    enum CodingKeys: String, CodingKey {
        case currency, price, id, name
        case productDescription = "description"
        case imgURL = "imgUrl"
        case reviews
    }

    init(currency: String, price: Int, id: String, name: String, productDescription: String, imgURL: String, reviews: [Review]) {
        self.currency = currency
        self.price = price
        self.id = id
        self.name = name
        self.productDescription = productDescription
        self.imgURL = imgURL
        self.reviews = reviews
    }
}

// MARK: - Review
class Review: Codable {
    let productID, locale: String
    let rating: Int
    let text: String

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case locale, rating, text
    }

    init(productID: String, locale: String, rating: Int, text: String) {
        self.productID = productID
        self.locale = locale
        self.rating = rating
        self.text = text
    }
}
