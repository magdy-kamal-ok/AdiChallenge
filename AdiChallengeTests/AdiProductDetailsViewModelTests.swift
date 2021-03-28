//
//  AdiProductDetailsViewModelTests.swift
//  AdiChallengeTests
//
//  Created by Magdy Kamal on 27/03/2021.
//

import XCTest
@testable import AdiChallenge

class AdiProductDetailsViewModelTests: XCTestCase {

    var sut: ProductDetailsViewModel?
    
    override func setUpWithError() throws {
        sut = ProductDetailsViewModel(product: Product(currency: "", price: 23, id: "id1", name: "My Product", productDescription: "desc", imgURL: "https://assets.adidas.com/images/w_320,h_320,f_auto,q_auto:sensitive,fl_lossy/6634cf36274b4ea5ac46ac4e00b2021e_9366/Superstar_Shoes_Black_FY0071_01_standard.jpg", reviews: []), coordinator: nil, postReview: MockedPostReview(requestHandler: MockedRequestFactory(fileName: "ValidPostReviewResponse")))
    }

    override func tearDownWithError() throws {
       sut = nil
    }

    func testErrorAlertModelState() throws {
        sut = ProductDetailsViewModel(product: Product(currency: "", price: 23, id: "id1", name: "My Product", productDescription: "desc", imgURL: "https://assets.adidas.com/images/w_320,h_320,f_auto,q_auto:sensitive,fl_lossy/6634cf36274b4ea5ac46ac4e00b2021e_9366/Superstar_Shoes_Black_FY0071_01_standard.jpg", reviews: []), coordinator: nil, postReview: MockedPostReview(requestHandler: MockedRequestFactory(fileName: "InvalidPostReviewResponse")))
        let expectation = XCTestExpectation(description: "testErrorAlertModelState")
        var adiAlertModel: AdiAlertModel? = nil
        sut?.state.showAlert.bind(on: self, block: { (self, alertModel) in
            defer { expectation.fulfill() }
            adiAlertModel = alertModel
        })
        sut?.didPressSubmitReview(text: "", rating: 4)
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(adiAlertModel)
        XCTAssertEqual(adiAlertModel?.title, "ERROR")
    }

    func testProductInfoData() throws {
        let productInfo: ProductPresentationModel? = sut?.productInfo
        XCTAssertEqual(productInfo?.description, "desc")
        XCTAssertEqual(productInfo?.name, "My Product")
        XCTAssertEqual(productInfo?.id, "id1")
        XCTAssertEqual(productInfo?.image, "https://assets.adidas.com/images/w_320,h_320,f_auto,q_auto:sensitive,fl_lossy/6634cf36274b4ea5ac46ac4e00b2021e_9366/Superstar_Shoes_Black_FY0071_01_standard.jpg")
    }
    
    func testProductDetailsSectionsCount() throws {
        XCTAssertEqual(sut?.sectionList.count, 2)
    }
    
}
