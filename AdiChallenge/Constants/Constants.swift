//
//  Constants.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import Foundation

class Constants {
    
    // MARK: Request Constants
    private static let baseURL = "http://localhost"
    public static let productsApiURL = baseURL + ":3001/product"
    public static let reviewsApiURL =  baseURL + ":3002/reviews/%@"
    
    // MARK: Adi CrashReporting Flag
    public static let isNonFatalErrorCrashlyticsLoggerEnabled = true
}
