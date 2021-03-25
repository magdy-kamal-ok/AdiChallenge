//
//  ErrorModel.swift
//  NetworkLayer
//
//  Created by Magdy Kamal on 29/01/2021.
//

import Foundation

public struct ErrorModel: Error {
    public var code: Int?
    public var message: String?
    public var error: String?
    public var url: String?
    
    public init(code: Int?, message: String?, error: String?, url: String?) {
        self.code = code
        self.message = message
        self.error = error
        self.url = url
    }

    public init() {
        self.init(code: nil, message: nil, error: nil, url: nil)
    }
}
