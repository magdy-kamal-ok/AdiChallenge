//
//  AdiChallengeProductDetailsUITests.swift
//  AdiChallengeUITests
//
//  Created by Magdy Kamal on 27/03/2021.
//

import XCTest
@testable import AdiChallenge

class AdiChallengeProductDetailsUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        openAdiProductDetails()
        continueAfterFailure = true
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func openAdiProductDetails() {
        app.launch()
        let tableView = app.tables.firstMatch
        let firstCell = tableView.cells.element(boundBy: 0)
        firstCell.tap()
    }
    
    func testAdiProductDetailsBackNavBarExists() throws {
        let leftNavButton = self.app.navigationBars.buttons["Back"]
        XCTAssert(leftNavButton.exists)
    }
    
    func testAdiProductDetailsTableViewExists() throws {
        XCTAssert(app.tables.firstMatch.exists)
    }
    
    func testAdiProductDetailsInfoNameLabelExists() throws {
        let tableView = app.tables.firstMatch
        let productInfoHeader = tableView.otherElements["AdiProductDetailsInfoHeaderIdentifier"]
        let nameLabel = productInfoHeader.staticTexts["AdiProductDetailsInfoNameLabelIdentifier"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: nameLabel, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testAdiProductDetailsInfoPriceLabelExists() throws {
        let tableView = app.tables.firstMatch
        let productInfoHeader = tableView.otherElements["AdiProductDetailsInfoHeaderIdentifier"]
        let priceLabel = productInfoHeader.staticTexts["AdiProductDetailsInfoPriceLabelIdentifier"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: priceLabel, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testAdiProductDetailsInfoDescriptionLabelExists() throws {
        let tableView = app.tables.firstMatch
        let productInfoHeader = tableView.otherElements["AdiProductDetailsInfoHeaderIdentifier"]
        let descriptionLabel = productInfoHeader.staticTexts["AdiProductDetailsInfoDescriptionLabelIdentifier"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: descriptionLabel, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testAdiProductDetailsInfoImageExists() throws {
        let tableView = app.tables.firstMatch
        let productInfoHeader = tableView.otherElements["AdiProductDetailsInfoHeaderIdentifier"]
        let productImage = productInfoHeader.images["AdiProductDetailsInfoImageIdentifier"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: productImage, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testAdiProductDetailsInfoHeaderExists() throws {
        let tableView = app.tables.firstMatch
        let productInfoHeader = tableView.otherElements["AdiProductDetailsInfoHeaderIdentifier"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: productInfoHeader, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testAdiProductDetailsReviewsHeaderExists() throws {
        let tableView = app.tables.firstMatch
        let productReviewsHeader = tableView.otherElements["AdiProductDetailsReviewsHeaderIdentifier"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: productReviewsHeader, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testAdiProductDetailsAddReviewButtonExists() throws {
        let tableView = app.tables.firstMatch
        let productReviewsHeader = tableView.otherElements["AdiProductDetailsReviewsHeaderIdentifier"]
        let addNewReviewBtn = productReviewsHeader.buttons["AdiProductDetailsAddReviewButtonIdentifier"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: addNewReviewBtn, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    func testAdiProductDetailsAlertViewSubmissionExists() throws {
        let tableView = app.tables.firstMatch
        let productReviewsHeader = tableView.otherElements["AdiProductDetailsReviewsHeaderIdentifier"]
        let addNewReviewBtn = productReviewsHeader.buttons["AdiProductDetailsAddReviewButtonIdentifier"]
        addNewReviewBtn.tap()
        XCTAssert(app.alerts.firstMatch.exists)
    }
    
    func testAdiProductDetailsAlertViewSubmissionButtonsExists() throws {
        let tableView = app.tables.firstMatch
        let productReviewsHeader = tableView.otherElements["AdiProductDetailsReviewsHeaderIdentifier"]
        let addNewReviewBtn = productReviewsHeader.buttons["AdiProductDetailsAddReviewButtonIdentifier"]
        addNewReviewBtn.tap()
        XCTAssert(app.alerts.firstMatch.buttons.count == 2)
    }
    
    func testAdiProductDetailsReviewTextViewExists() throws {
        let tableView = app.tables.firstMatch
        let productReviewsHeader = tableView.otherElements["AdiProductDetailsReviewsHeaderIdentifier"]
        let addNewReviewBtn = productReviewsHeader.buttons["AdiProductDetailsAddReviewButtonIdentifier"]
        addNewReviewBtn.tap()
        let textView = app.alerts.firstMatch.textViews["AdiProductDetailsReviewTextViewIdentifier"]
        XCTAssert(textView.exists)
    }
    
    func testAdiProductDetailsReviewRatingExists() throws {
        let tableView = app.tables.firstMatch
        let productReviewsHeader = tableView.otherElements["AdiProductDetailsReviewsHeaderIdentifier"]
        let addNewReviewBtn = productReviewsHeader.buttons["AdiProductDetailsAddReviewButtonIdentifier"]
        addNewReviewBtn.tap()
        let ratingView = app.alerts.firstMatch.otherElements["AdiProductDetailsReviewRatingIdentifier"]
        XCTAssert(ratingView.exists)
    }
}

