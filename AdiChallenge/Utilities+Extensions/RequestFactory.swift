//
//  RequestFactory.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import Foundation
import NetworkLayer

public class RequestFactory: RequstHandlerProtocol {

    var url: String
    var method: RequestMethod
    var headers: [String: String]?
    var parameters: [String: Any]?
    var encoding: RequestEncoding

    init(url: String,
         method: RequestMethod = .get,
         headers: [String: String]? = ["Content-Type": "application/json", "Accept-Language": "en-US"],
         parameters: [String: Any]? = nil,
         encoding: RequestEncoding = .jsonEncoding) {
        self.url = url
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.encoding = encoding
    }
    
    convenience init(url: String, method: RequestMethod = .get) {
        self.init(url: url, method: method, headers: ["Content-Type": "application/json", "Accept-Language": "en-US"], parameters: nil, encoding: .jsonEncoding)
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
    
    public func getAutoRetryCount() -> Int {
        3
    }
}


struct AdiErrorModel: Codable, Error {
    let message: String
}
