//
//  URLSessionApiClientManager.swift
//  NetworkLayer
//
//  Created by Magdy Kamal on 29/01/2021.
//

import Foundation


public class URLSessionApiClientManager: NetworkManagerProtocol {
    
    private var defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    private var isForcingCancel = false
    
    public init() { }
        
    private func getStatus(_ response: HTTPURLResponse) -> URLResponseStatus {
        switch response.statusCode {
            case 200...299: return .success
            default: return .failure
        }
    }
    
    public func cancelRequest() {
        dataTask?.cancel()
        isForcingCancel = true
    }
    
    public func fetchResponse(apiComponents: RequstHandlerProtocol, completionHandler: @escaping ResponseResult) {
        
        if !Reachability.isConnectedToNetwork() {
            let requestCanceledError = ErrorModel(code:  LocalError.noInternetConnection.errorCode, message: LocalError.noInternetConnection.localizedDescription, error: nil, url: apiComponents.getApiUrl())
            completionHandler(ResultModel.faliure(requestCanceledError, nil))
        }
        let request = URLRequest(requestHanler: apiComponents)
        dataTask = defaultSession.dataTask(with: request, completionHandler: { [weak self] data, response, error in
                guard let self = self else { return }
                defer { self.dataTask = nil }
                let response = response as? HTTPURLResponse
            
                if let error = error, let response = response {
                    if self.isForcingCancel {
                        let requestCanceledError = ErrorModel(code:  LocalError.requestCanceled.errorCode, message: LocalError.requestCanceled.localizedDescription, error: nil, url: apiComponents.getApiUrl())
                        completionHandler(ResultModel.faliure(requestCanceledError, nil))
                    } else {
                        let customError = ErrorModel(code:  response.statusCode, message: error.localizedDescription, error: nil, url: apiComponents.getApiUrl())
                        completionHandler(ResultModel.faliure(customError, nil))
                    }
                    
                } else if let data = data {
                   if let response = response {
                    let resultStatus = self.getStatus(response)
                    switch resultStatus {
                        case .success:
                            completionHandler(ResultModel.success(data))
                        case .failure:
                            completionHandler(ResultModel.faliure(nil, data))
                        }
                    }
                } else {
                    let unknownError = ErrorModel(code:  LocalError.unknownError.errorCode, message: LocalError.unknownError.localizedDescription, error: nil, url: apiComponents.getApiUrl())
                    completionHandler(ResultModel.faliure(unknownError, nil))
                }
            })
        dataTask?.resume()
    }
    

}
