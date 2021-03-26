//
//  HomeRepository.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import Foundation
import NetworkLayer

protocol HomeRepositoryProtocol {
    typealias RepositoryResult = (Result<[Product], AdiErrorModel>) -> Void
    init(requestHandler: RequstHandlerProtocol)
    func fetchProducts(_ completionHandler: @escaping RepositoryResult)
    func cancelRequest()
}

extension HomeRepositoryProtocol {
    init(requestHandler: RequstHandlerProtocol) {
        self.init(requestHandler: requestHandler)
    }
}

class HomeRepository: HomeRepositoryProtocol {
    
    private let remoteDataSource: HomeRepositoryProtocol

    init(remoteDataSource: HomeRepositoryProtocol = RemoteHomeDataSource(requstHandler: RequestFactory(url: Constants.productsApiURL))) {
        self.remoteDataSource = remoteDataSource
    }

    func fetchProducts(_ completionHandler: @escaping RepositoryResult) {
        remoteDataSource.fetchProducts(completionHandler)
    }

    func cancelRequest() {
        remoteDataSource.cancelRequest()
    }
}
