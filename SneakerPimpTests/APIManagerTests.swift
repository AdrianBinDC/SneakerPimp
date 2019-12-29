//
//  SneakerHeadTests.swift
//  SneakerHeadTests
//
//  Created by Adrian Bolinger on 12/28/19.
//  Copyright © 2019 Adrian Bolinger. All rights reserved.
//

import XCTest
@testable import SneakerPimp

class APIManagerTests: XCTestCase {
    func testUrlForPageNumber() {
        let basePage = "https://www.kicksonfire.com/app/upcoming"
        let pageTwo = "https://www.kicksonfire.com/app/upcoming?page=2"
        let apiManager = APIManager()
        XCTAssertEqual(basePage, apiManager.urlFor(pageNumber: 0))
        XCTAssertEqual(pageTwo, apiManager.urlFor(pageNumber: 1))
    }
    
    func testScrape() {
        let exp = expectation(description: "scrape")
        let apiManager = APIManager()
        apiManager.scrape(url: KicksOnFireURL.releaseCalendar.rawValue)
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
