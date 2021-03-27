//
//  MockedPostReview.swift
//  AdiChallengeTests
//
//  Created by Magdy Kamal on 27/03/2021.
//

import Foundation
import NetworkLayer
@testable import AdiChallenge

class MockedPostReview: PostReviewProtocol {
  
    let requestHandler: RequstHandlerProtocol
    
    required init(requestHandler: RequstHandlerProtocol) {
        self.requestHandler = requestHandler
    }
    func postReview(params: [String : Any], _ completionHandler: @escaping PostReviewResult) {
        let bundle = Bundle(for: MockedPostReview.self)
        let dataPath = bundle.url(forResource: requestHandler.getApiUrl(), withExtension: "json")
        do {
            let data = try Data(contentsOf: dataPath!)
            if let parsedObj: Review = CodableParserManager().parseData(data: data) {
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
