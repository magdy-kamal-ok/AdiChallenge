//
//  AdiChallengeHomeViewModelTests.swift
//  AdiChallengeTests
//
//  Created by Magdy Kamal on 25/03/2021.
//

import XCTest
@testable import AdiChallenge

class AdiChallengeHomeViewModelTests: XCTestCase {

    var sut: AdiHomeViewModel?
    
    override func setUpWithError() throws {
        sut = AdiHomeViewModel(homeRepository: MockedHomeRepository(requestHandler: MockedRequestFactory(fileName: "ValidAdiProducts")), coordinator: nil)
    }

    override func tearDownWithError() throws {
       sut = nil
    }

    func testIsLoadingState() throws {
        let expectation = XCTestExpectation(description: "testIsLoadingState")
        var isLoading: Bool? = nil
        sut?.state.isLoading.bind(on: self, block: { (self, isLoadingArg) in
            defer { expectation.fulfill() }
            isLoading = isLoadingArg
        })
        sut?.fetchProducts()
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(isLoading)
    }
    
    func testReloadDataState() throws {
        let expectation = XCTestExpectation(description: "testReloadDataState")
        var products: [ProductPresentationModel]? = nil
        sut?.state.reloadData.bind(on: self, block: { (self, _) in
            defer { expectation.fulfill() }
            products = self.sut?.products
        })
        sut?.fetchProducts()
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(products)
    }

    func testErrorAlertModelState() throws {
        sut = AdiHomeViewModel(homeRepository: MockedHomeRepository(requestHandler: MockedRequestFactory(fileName: "InvalidAdiProducts")), coordinator: nil)
        let expectation = XCTestExpectation(description: "testErrorAlertModelState")
        var adiAlertModel: AdiAlertModel? = nil
        sut?.state.showAlert.bind(on: self, block: { (self, alertModel) in
            defer { expectation.fulfill() }
            adiAlertModel = alertModel
        })
        sut?.fetchProducts()
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(adiAlertModel)
        XCTAssertEqual(adiAlertModel?.title, "ERROR")
    }
    
    func testProductsCountWithoutSearch() throws {
        let expectation = XCTestExpectation(description: "testProductsCountWithoutSearch")
        var products: [ProductPresentationModel]? = nil
        sut?.state.reloadData.bind(on: self, block: { (self, _) in
            defer { expectation.fulfill() }
            products = self.sut?.products
        })
        sut?.fetchProducts()
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(products?.count, 2)
    }

    func testProductsCountWithSearch() throws {
        let expectation = XCTestExpectation(description: "testProductsCountWithSearch")
        var products: [ProductPresentationModel]? = nil
        sut?.state.reloadData.bind(on: self, block: { (self, _) in
            defer { expectation.fulfill() }
            products = self.sut?.products
        })
        sut?.searchText = "COURT"
        sut?.fetchProducts()
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(products?.count, 1)
    }
}
