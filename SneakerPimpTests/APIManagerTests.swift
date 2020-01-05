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
        
        apiManager.shoesSubject
            .sink(receiveCompletion: { [weak self] value in
                guard self != nil else { return }
                switch value {
                case .finished:
                    print("apiManager.shoesSubject .finished")
                    break
                }
            }) { [weak self] shoes in
                guard self != nil else { return }
                XCTAssertNotNil(shoes)
                print(shoes)
                exp.fulfill()
        }
        
        apiManager.scrape(page: .L1(pageNumber: 0))
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
