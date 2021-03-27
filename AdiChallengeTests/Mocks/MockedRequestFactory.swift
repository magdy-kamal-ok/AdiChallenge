//
//  MockedRequestFactory.swift
//  AdiChallengeTests
//
//  Created by Magdy Kamal on 27/03/2021.
//

import Foundation
import NetworkLayer
@testable import AdiChallenge

class MockedRequestFactory: RequstHandlerProtocol {

    var fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func getApiUrl() -> String {
        return fileName
    }
    
    func getHttpMethod() -> RequestMethod {
        return .get
    }
    
    func getRequestHeaders() -> [String : String]? {
        return nil
    }
    
    func getRequestParameters() -> [String : Any]? {
        return nil
    }
    
    func getRequestEncoding() -> RequestEncoding {
        return .urlEncoding
    }
    
    func setRequestParameters(params: [String : Any]?) {

    }
    
    func getAutoRetryCount() -> Int {
        3
    }
}
