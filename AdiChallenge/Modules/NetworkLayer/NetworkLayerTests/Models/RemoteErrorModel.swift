//
//  RemoteErrorModel.swift
//  NetworkLayerTests
//
//  Created by Magdy Kamal on 29/01/2021.
//

import Foundation

public struct RemoteErrorModel: Decodable, Error {
    public let message: String
    public let code: Int
}
