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

    /*
     https://www.kicksonfire.com/app/upcoming
     https://www.kicksonfire.com/app/upcoming?page=2
     */
    
    func testUrlForPageNumber() {
        let basePage = "https://www.kicksonfire.com/app/upcoming"
        let pageTwo = "https://www.kicksonfire.com/app/upcoming?page=2"
        
        let apiManager = APIManager()
        XCTAssertEqual(basePage, apiManager.urlFor(pageNumber: 0))
        XCTAssertEqual(pageTwo, apiManager.urlFor(pageNumber: 1))
    }
}
