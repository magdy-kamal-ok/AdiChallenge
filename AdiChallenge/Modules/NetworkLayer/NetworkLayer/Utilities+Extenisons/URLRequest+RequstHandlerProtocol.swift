//
//  URLRequest+RequstHandlerProtocol.swift
//  NetworkLayer
//
//  Created by Magdy Kamal on 29/01/2021.
//

import Foundation

extension URLRequest {

    init(requestHanler: RequstHandlerProtocol) {
        let urlComponents = URLComponents(requestHanler: requestHanler)

        self.init(url: urlComponents.url!)

        httpMethod = requestHanler.getHttpMethod().rawValue
        requestHanler.getRequestHeaders()?.forEach { key, value in
            addValue(value, forHTTPHeaderField: key)
        }

        if case .jsonEncoding = requestHanler.getRequestEncoding() {
            if let parameters = requestHanler.getRequestParameters() {
                httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            }
        }

    }
}
