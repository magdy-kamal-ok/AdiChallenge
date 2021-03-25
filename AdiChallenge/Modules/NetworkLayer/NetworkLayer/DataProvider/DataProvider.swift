//
//  DataProvider.swift
//  NetworkLayer
//
//  Created by Magdy Kamal on 29/01/2021.
//

import Foundation

public class DataProvider<R, E> where E: Decodable & Error, R: Decodable {
    public typealias DataProviderResponseResult = ((R?, Error?)) -> Void

    public private(set) var requestHandler: RequstHandlerProtocol!
    private var apiClientManager: NetworkManagerProtocol!
    private var parser: ParserHandlerProtocol!

    public init(requestHandler: RequstHandlerProtocol, apiClientManager: NetworkManagerProtocol = URLSessionApiClientManager(), parser: ParserHandlerProtocol = CodableParserManager()) {

        self.apiClientManager = apiClientManager
        self.requestHandler = requestHandler
        self.parser = parser
    }
    
    public func execute(completionHandler: @escaping DataProviderResponseResult) {
        fetchResponse(apiComponents: requestHandler) { [weak self] result in
            guard let self = self else { return }
            completionHandler(self.handleResult(response: result))
        }
    }

    private func handleResult(response: ResultModel) -> (R? ,Error?) {
        switch response {
        case .faliure(let error, let data):
            return (nil, self.handleError(error: (error, data)))
        case .success(let data):
            return self.handleSuccessData(data: data)
        }
    }
    
    private func handleSuccessData(data:Data) -> (R? ,Error?) {
        if let parsedObject:R = self.parser.parseData(data: data) {
            return (parsedObject, nil)
        } else {
            let error = self.createCustomError(localError: .parsingFailure)
            return (nil, error)
        }
    }
    
    private func handleError(error: (Error?, Data?)) -> Error {
        if let error = error.0 {
            return error
        } else if let errorData = error.1, let parsedError:E = self.parser.parseData(data: errorData) {
            return parsedError
        } else {
            return createCustomError(localError: .unknownError)
        }
    }
    
    private func createCustomError(localError: LocalError) -> ErrorModel {
        var error = ErrorModel()
        error.code = localError.errorCode
        error.message = localError.localizedDescription
        error.url = self.requestHandler.getApiUrl()
        return error
    }
}

extension DataProvider: NetworkManagerProtocol {
    
    public func cancelRequest() {
        apiClientManager.cancelRequest()
    }
    
    public func fetchResponse(apiComponents: RequstHandlerProtocol, completionHandler: @escaping ResponseResult) {
        apiClientManager.fetchResponse(apiComponents: apiComponents, completionHandler: completionHandler)
    }
}
