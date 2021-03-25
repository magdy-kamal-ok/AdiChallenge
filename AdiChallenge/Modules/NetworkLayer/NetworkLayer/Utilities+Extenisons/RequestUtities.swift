//
//  RequestUtities.swift
//  NetworkLayer
//
//  Created by Magdy Kamal on 29/01/2021.
//

import Foundation

public enum RequestMethod: String {
    case post       = "POST"
    case get        = "GET"
    case put        = "PUT"
    case delete     = "DELETE"
    case patch      = "PATCH"
}

public enum RequestEncoding {
    case urlEncoding
    case jsonEncoding
}

enum URLResponseStatus {
    case success
    case failure
}
