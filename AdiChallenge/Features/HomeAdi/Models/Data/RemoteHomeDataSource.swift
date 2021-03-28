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
    private let logger: NonFatalErrorLogger
    required init(requestHandler: RequstHandlerProtocol, logger: NonFatalErrorLogger = CrashlyticsLogger.shared) {
        self.logger = logger
        dataProvider = DataProvider(requestHandler: requestHandler)
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
                self.logger.logNonFatalError(error: error)
                completionHandler(.failure(error))
            } else if let error = response.1 as? ErrorModel, let message = error.message {
                self.logger.logNonFatalError(error: error)
                completionHandler(.failure(AdiErrorModel(message: message)))
            } else {
                let unknownError = self.getUnknownError()
                self.logger.logNonFatalError(error: unknownError)
                completionHandler(.failure(AdiErrorModel(message: unknownError.message!)))
            }
        }
    }
}
