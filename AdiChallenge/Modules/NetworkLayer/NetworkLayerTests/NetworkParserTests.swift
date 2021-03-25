//
//  NetworkParserTests.swift
//  NetworkLayerTests
//
//  Created by Magdy Kamal on 29/01/2021.
//

import XCTest
@testable import NetworkLayer

class NetworkParserTests: XCTestCase {

    var sut: ParserHandlerProtocol!

    override func setUp() {
        sut = CodableParserManager()
    }

    override func tearDown() {
        sut = nil
    }

    func testParsingDataSuccess() {
        let bundle = Bundle(for: NetworkParserTests.self)
        let dataPath = bundle.url(forResource: "UserResponseModel", withExtension: "json")
        let data = try! Data(contentsOf: dataPath!)
        var parsedModel: UserProfileResponseModel?
        if let userModel: UserProfileResponseModel = sut.parseData(data: data) {
            parsedModel = userModel
        }
        XCTAssertNotNil(parsedModel)
        XCTAssert(parsedModel?.contactNumbers.count == 2)
        XCTAssert(parsedModel?.user.name == "ASD")
        XCTAssert(parsedModel?.user.image == "IMAGE")

    }

}
