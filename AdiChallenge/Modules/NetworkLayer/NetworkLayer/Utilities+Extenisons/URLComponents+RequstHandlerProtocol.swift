//
//  URLComponents+RequstHandlerProtocol.swift
//  NetworkLayer
//
//  Created by Magdy Kamal on 29/01/2021.
//

import Foundation

extension URLComponents {

    init(requestHanler: RequstHandlerProtocol) {
        
        let url = URL(string: requestHanler.getApiUrl())!
        self.init(url: url, resolvingAgainstBaseURL: false)!
        if case .urlEncoding = requestHanler.getRequestEncoding() {
            if let params = requestHanler.getRequestParameters() {
                queryItems = params.map { key, value in
                    return URLQueryItem(name: key, value: String(describing: value))
                }
            }
        }
        
    }
}

