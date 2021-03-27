//
//  PostReview.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 26/03/2021.
//

import NetworkLayer

protocol PostReviewProtocol {
    typealias PostReviewResult = (Result<Review, AdiErrorModel>) -> Void
    init(requestHandler: RequstHandlerProtocol, logger: NonFatalErrorLogger)
    func postReview(params: [String: Any], _ completionHandler: @escaping PostReviewResult)
    func cancelRequest()
}

class PostReview: PostReviewProtocol {
    
    private let dataProvider: DataProvider<Review, AdiErrorModel>
    
    required init(requestHandler: RequstHandlerProtocol, logger: NonFatalErrorLogger = CrashlyticsLogger.shared) {
        dataProvider = DataProvider(requestHandler: requestHandler)
    }
    
    private func getUnknownError() -> ErrorModel {
        ErrorModel(code: LocalError.unknownError.errorCode, message: LocalError.unknownError.localizedDescription, error: LocalError.unknownError.localizedDescription, url: Constants.productsApiURL)
    }
    
    func cancelRequest() {
        dataProvider.cancelRequest()
    }
    
    func postReview(params: [String: Any],_ completionHandler: @escaping PostReviewResult) {
        dataProvider.requestHandler.setRequestParameters(params: params)
        dataProvider.execute { [weak self] response in
            guard let self = self else { return }
            if let review = response.0 {
                completionHandler(.success(review))
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
