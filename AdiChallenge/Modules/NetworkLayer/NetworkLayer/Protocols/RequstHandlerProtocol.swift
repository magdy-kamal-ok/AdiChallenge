//
//  RequstHandlerProtocol.swift
//  NetworkLayer
//
//  Created by Magdy Kamal on 29/01/2021.
//

import Foundation

public protocol RequstHandlerProtocol {
    func getApiUrl()                   -> String
    func getHttpMethod()               -> RequestMethod
    func getRequestHeaders()           -> [String: String]?
    func getRequestParameters()        -> [String: Any]?
    func getRequestEncoding()          -> RequestEncoding
    func setRequestParameters(params: [String: Any]?)
}
