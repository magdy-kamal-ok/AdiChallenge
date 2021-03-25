//
//  ErrorTypes.swift
//  NetworkLayer
//
//  Created by Magdy Kamal on 29/01/2021.
//

import Foundation

public enum LocalError: Error {
    
    case noInternetConnection
    case timeOut
    case parsingFailure
    case requestCanceled
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .noInternetConnection: return "Internet Connection Error"
        case .timeOut: return "Time out"
        case .parsingFailure: return "Parsing Failure"
        case .requestCanceled: return "request has been Canceled"
        case .unknownError:
            return "unknown Error Please Try Again after 1 minute"
        }
    }

    public var errorCode:Int {
        switch self {
        case .noInternetConnection:
            return LocalErrorCode.noInternetConnection.rawValue
        case .timeOut:
            return LocalErrorCode.timeOut.rawValue
        case .parsingFailure:
            return LocalErrorCode.parsingFailure.rawValue
        case .requestCanceled: return LocalErrorCode.requestCanceled.rawValue
        case .unknownError:
            return LocalErrorCode.unknownError.rawValue
        }
    }
}

public enum LocalErrorCode: Int {
    case noInternetConnection = 5000
    case timeOut = 5001
    case parsingFailure = 5002
    case requestCanceled = 5003
    case unknownError = 5004
}
