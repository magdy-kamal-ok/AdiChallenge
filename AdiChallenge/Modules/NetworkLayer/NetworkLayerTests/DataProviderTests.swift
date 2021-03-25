//
//  DataProviderTests.swift
//  NetworkLayerTests
//
//  Created by Magdy Kamal on 29/01/2021.
//

import XCTest
@testable import NetworkLayer

class DataProviderTests: XCTestCase {

    var sut: DataProvider<UserProfileResponseModel, RemoteErrorModel>?
    
    override func setUp() {

    }

    override func tearDown() {
        sut = nil
    }

    func testDataProviderSuccess() {
        let expectation = XCTestExpectation(description: "testDataProviderSuccess")
        let requestFactory = MockedRequestFactory(fileName: "UserResponseModel")
        sut = DataProvider(requestHandler: requestFactory, apiClientManager: MockedNetworkManager(), parser: CodableParserManager())
        var userResponseModelStub: UserProfileResponseModel?
        var error: ErrorModel?
        sut?.execute(completionHandler: {  response in
            if let userResponse = response.0 {
                userResponseModelStub = userResponse
            } else {
                error = response.1 as? ErrorModel
            }
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(userResponseModelStub)
        XCTAssertNil(error)
    }

    func testDataProviderSuccessArray() {
        let expectation = XCTestExpectation(description: "testDataProviderSuccessArray")
        let requestFactory = MockedRequestFactory(fileName: "UserResponseArray")
        let anotherSut = DataProvider<[UserProfileResponseModel], RemoteErrorModel>(requestHandler: requestFactory, apiClientManager: MockedNetworkManager(), parser: CodableParserManager())
        var userResponseModelStub: [UserProfileResponseModel]?
        var error: ErrorModel?
        anotherSut.execute(completionHandler: {  response in
            if let userResponse = response.0 {
                userResponseModelStub = userResponse
            } else {
                error = response.1 as? ErrorModel
            }
                expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(userResponseModelStub)
        XCTAssertNil(error)
    }
    
    func testDataProviderFailure() {
        let expectation = XCTestExpectation(description: "testDataProviderFailure")
        let requestFactory = MockedRequestFactory(fileName: "UserFakeResponseModel")
        sut = DataProvider(requestHandler: requestFactory, apiClientManager: MockedNetworkManager(), parser: CodableParserManager())
        var userResponseModelStub: UserProfileResponseModel?
        var error: ErrorModel?
        sut?.execute(completionHandler: {  response in
            if let userResponse = response.0 {
                userResponseModelStub = userResponse
            } else {
                error = response.1 as? ErrorModel
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(error)
        XCTAssertEqual(error?.code, LocalError.parsingFailure.errorCode)
        XCTAssertNil(userResponseModelStub)
    }
    
}
