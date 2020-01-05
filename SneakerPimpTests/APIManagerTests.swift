//
//  SneakerHeadTests.swift
//  SneakerHeadTests
//
//  Created by Adrian Bolinger on 12/28/19.
//  Copyright © 2019 Adrian Bolinger. All rights reserved.
//

import Combine
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
        var subscription = Set<AnyCancellable>()
        
        let apiManager = APIManager()
        let publisher = apiManager.shoePublisher
                
        _ = publisher.sink { shoes in
                XCTAssertNotNil(shoes)
                print(shoes)
                exp.fulfill()
        }.store(in: &subscription)
        
        apiManager.scrape(page: .L1(pageNumber: 0))
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
