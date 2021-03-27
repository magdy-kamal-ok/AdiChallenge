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
    
    required init(requestHandler: RequstHandlerProtocol) {
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
                completionHandler(.failure(AdiErrorModel(message: LocalError.unknownError.localizedDescription)))
            }
        } catch {
            completionHandler(.failure(AdiErrorModel(message: LocalError.parsingFailure.localizedDescription)))
        }
    }
    
    func cancelRequest() {
        
    }    
}
