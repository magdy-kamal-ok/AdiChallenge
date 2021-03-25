//
//  NetworkManagerProtocol.swift
//  NetworkLayer
//
//  Created by Magdy Kamal on 29/01/2021.
//

import Foundation

public protocol NetworkManagerProtocol {
    typealias ResponseResult = (ResultModel) -> Void
    func fetchResponse(apiComponents: RequstHandlerProtocol, completionHandler: @escaping ResponseResult)
    func cancelRequest()
}
