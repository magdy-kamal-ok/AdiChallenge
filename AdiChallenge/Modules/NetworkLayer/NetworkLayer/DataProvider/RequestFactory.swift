//
//  RequestFactory.swift
//  NetworkLayer
//
//  Created by Magdy Kamal on 29/01/2021.
//

import Foundation

public class RequestFactory: RequstHandlerProtocol {

    var url: String
    var method: RequestMethod
    var headers: [String: String]?
    var parameters: [String: Any]?
    var encoding: RequestEncoding

    public init(url: String,
         method: RequestMethod = .get,
         headers: [String: String]? = ["Content-Type": "application/json"],
         parameters: [String: Any] = [:],
         encoding: RequestEncoding = .urlEncoding) {
        self.url = url
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.encoding = encoding

    }
    
    public func getApiUrl() -> String {
        return url
    }
    
    public func getHttpMethod() -> RequestMethod {
        return method
    }
    
    public func getRequestHeaders() -> [String : String]? {
        return headers
    }
    
    public func getRequestParameters() -> [String : Any]? {
        return parameters
    }
    
    public func getRequestEncoding() -> RequestEncoding {
        return encoding
    }
    
    public func setRequestParameters(params: [String : Any]?) {
        self.parameters = params
    }
}
