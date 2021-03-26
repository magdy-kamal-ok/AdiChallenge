//
//  RemoteHomeDataSource.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import Foundation
import NetworkLayer

class RemoteHomeDataSource: HomeRepositoryProtocol {
    
    private let dataProvider: DataProvider<[Product], AdiErrorModel>
    
    required init(requstHandler: RequstHandlerProtocol) {
        dataProvider = DataProvider(requestHandler: requstHandler)
    }
    
    private func getUnknownError() -> ErrorModel {
        ErrorModel(code: LocalError.unknownError.errorCode, message: LocalError.unknownError.localizedDescription, error: LocalError.unknownError.localizedDescription, url: Constants.productsApiURL)
    }
    
    func cancelRequest() {
        dataProvider.cancelRequest()
    }
    
    func fetchProducts(_ completionHandler: @escaping RepositoryResult) {
        dataProvider.execute { [weak self] response in
            guard let self = self else { return }
            if let products = response.0 {
                completionHandler(.success(products))
            } else if let error = response.1 as? AdiErrorModel {
                completionHandler(.failure(error))
            } else if let error = response.1 as? ErrorModel, let message = error.message {
                completionHandler(.failure(AdiErrorModel(message: message)))
            } else {
                completionHandler(.failure(AdiErrorModel(message: self.getUnknownError().message!)))
            }
        }
    }
}
