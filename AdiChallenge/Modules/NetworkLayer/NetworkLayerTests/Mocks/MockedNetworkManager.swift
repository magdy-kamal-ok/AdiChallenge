//
//  MockedNetworkManager.swift
//  NetworkLayerTests
//
//  Created by Magdy Kamal on 29/01/2021.
//

import Foundation
@testable import NetworkLayer

class MockedNetworkManager: NetworkManagerProtocol {
    
    func cancelRequest() {
        
    }
    
    func fetchResponse(apiComponents: RequstHandlerProtocol, completionHandler: @escaping ResponseResult) {
        let bundle = Bundle(for: MockedNetworkManager.self)
        let dataPath = bundle.url(forResource: apiComponents.getApiUrl(), withExtension: "json")
        var responseData: Data
        do {
            let data = try Data(contentsOf: dataPath!)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            let dataObj = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            responseData = dataObj
            completionHandler(ResultModel.success(responseData))
        } catch {
            let customError = ErrorModel(code: LocalError.parsingFailure.errorCode, message: LocalError.parsingFailure.localizedDescription, error: LocalError.parsingFailure.localizedDescription, url: apiComponents.getApiUrl())
            completionHandler(ResultModel.faliure(customError, nil))
        }
    }
    
}
