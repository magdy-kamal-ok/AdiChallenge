//
//  CodableParserManager.swift
//  NetworkLayer
//
//  Created by Magdy Kamal on 29/01/2021.
//

import Foundation

public struct CodableParserManager: ParserHandlerProtocol {
    
    public init() { }

    public func parseData<T: Decodable>(data: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            let item = try decoder.decode(T.self, from: data)
            return item
        } catch {
            return nil
        }
    }
}
