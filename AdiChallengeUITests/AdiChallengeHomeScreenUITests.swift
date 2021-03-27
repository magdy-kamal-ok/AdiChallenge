//
//  AdiChallengeHomeScreenUITests.swift
//  AdiChallengeHomeScreenUITests
//
//  Created by Magdy Kamal on 25/03/2021.
//

import XCTest
@testable import AdiChallenge
class AdiChallengeHomeScreenUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        continueAfterFailure = true
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testAdiProductsTableViewExists() throws {
        app.launch()
        XCTAssert(app.tables.firstMatch.exists)
    }
    
    func testAdiProductsSearchBarExists() throws {
        app.launch()
        let searchBar = app.searchFields.firstMatch
        XCTAssert(searchBar.exists)
    }
    
    func testAdiActivityLoadingIncicatorExists() throws {
        app.launch()
        XCTAssert(app.activityIndicators.firstMatch.exists)
    }
    
    func testAdiPullToRefresh() throws {
        app.launch()
        let tableView = app.tables.firstMatch
        let firstCell = tableView.cells.element(boundBy: 0)
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 5))
        start.press(forDuration: 0, thenDragTo: finish)
    }
    
    func testAdiProductInfoNameLabelExists() throws {
        app.launch()
        let tableView = app.tables.firstMatch
        let cells = tableView.cells.firstMatch
        let nameLabel = cells.firstMatch.staticTexts["AdiProductInfoNameLabelIdentifier"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: nameLabel, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testAdiProductInfoPriceLabelExists() throws {
        app.launch()
        let tableView = app.tables.firstMatch
        let cells = tableView.cells.firstMatch
        let priceLabel = cells.firstMatch.staticTexts["AdiProductInfoPriceLabelIdentifier"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: priceLabel, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testAdiProductInfoDescriptionLabelExists() throws {
        app.launch()
        let tableView = app.tables.firstMatch
        let cells = tableView.cells.firstMatch
        let descriptionLabel = cells.firstMatch.staticTexts["AdiProductInfoDescriptionLabelIdentifier"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: descriptionLabel, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testAdiProductInfoImageExists() throws {
        app.launch()
        let tableView = app.tables.firstMatch
        let cells = tableView.cells.firstMatch
        let productImage = cells.firstMatch.images["AdiProductInfoImageIdentifier"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: productImage, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testAdiProductInfoOpenDetails() throws {
        app.launch()
        let tableView = app.tables.firstMatch
        let firstCell = tableView.cells.element(boundBy: 0)
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: firstCell) { () -> Bool in
            firstCell.tap()
            let leftNavButton = self.app.navigationBars.buttons["Back"]
            XCTAssert(leftNavButton.exists)
            return leftNavButton.exists
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
