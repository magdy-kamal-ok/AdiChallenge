//
//  ParserHandlerProtocol.swift
//  NetworkLayer
//
//  Created by Magdy Kamal on 29/01/2021.
//

import Foundation

public protocol ParserHandlerProtocol {
    func parseData<T: Decodable>(data:Data) -> T?
}
