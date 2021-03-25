//
//  UserProfileResponseModel.swift
//  NetworkLayerTests
//
//  Created by Magdy Kamal on 29/01/2021.
//

import Foundation

struct UserProfileResponseModel: Decodable {
    
    struct UserModel: Decodable {
        var name: String
        var image: String
    }
    
    var user: UserModel
    var contactNumbers: [String]
}
