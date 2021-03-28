//
//  MockedHomeRepository.swift
//  AdiChallengeTests
//
//  Created by Magdy Kamal on 27/03/2021.
//

import Foundation
import NetworkLayer
@testable import AdiChallenge

class MockedHomeRepository: HomeRepositoryProtocol {
  
    let requestHandler: RequstHandlerProtocol
    let logger: NonFatalErrorLogger

    required init(requestHandler: RequstHandlerProtocol, logger: NonFatalErrorLogger = MockedNonFatalErrorLogger()) {
        self.logger = logger
        self.requestHandler = requestHandler
    }
    
    func fetchProducts(_ completionHandler: @escaping RepositoryResult) {
        let bundle = Bundle(for: MockedHomeRepository.self)
        let dataPath = bundle.url(forResource: requestHandler.getApiUrl(), withExtension: "json")
        do {
            let data = try Data(contentsOf: dataPath!)
            if let parsedObj: [Product] = CodableParserManager().parseData(data: data) {
                completionHandler(.success(parsedObj))
            } else {
                logger.logNonFatalError(error: LocalError.unknownError)
                completionHandler(.failure(AdiErrorModel(message: LocalError.unknownError.localizedDescription)))
            }
        } catch {
            logger.logNonFatalError(error: LocalError.parsingFailure)
            completionHandler(.failure(AdiErrorModel(message: LocalError.parsingFailure.localizedDescription)))
        }
    }
    
    func cancelRequest() {
        
    }    
}
