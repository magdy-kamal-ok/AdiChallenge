//
//  RequestFactoryTests.swift
//  NetworkLayerTests
//
//  Created by Magdy Kamal on 29/01/2021.
//

import XCTest
@testable import NetworkLayer

class RequestFactoryTests: XCTestCase {
    var sut: RequstHandlerProtocol?
    let url = "https://www.forSale.com/2.0/"
    
    override func setUp() {
        sut = RequestFactory(url: url)
    }

    override func tearDown() {
        sut = nil
    }


    func testRequestFactoryEndPointSuccess() {
        XCTAssert(sut?.getApiUrl() == url)
    }
    
    func testRequestFactoryEndPointFailure() {
        sut = nil
        XCTAssertNotEqual(sut?.getApiUrl(), url)
    }
}
