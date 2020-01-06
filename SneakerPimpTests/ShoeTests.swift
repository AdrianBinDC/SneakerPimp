//
//  ShoeTests.swift
//  SneakerHeadTests
//
//  Created by Adrian Bolinger on 12/28/19.
//  Copyright © 2019 Adrian Bolinger. All rights reserved.
//

import XCTest
@testable import SneakerPimp


class ShoeTests: XCTestCase {
    private lazy var structWithL1Data: Shoe = {
        return Shoe(name: "Nike KD 12 Aunt Pearl",
                    releaseDate: Date(),
                    images: nil,
                    wants: nil,
                    color: nil,
                    styleCode: "",
                    retailPrices: [],
                    currentPrices: [])
    }()
    
    private lazy var structWithL2Data: Shoe = {
        return Shoe(name: "Undefeated x Nike Air Max 90 Black Solar Red",
                    releaseDate: Date(),
                    images: nil,
                    wants: [Want(want: 10, date: Date())],
                    color: nil,
                    styleCode: "",
                    retailPrices: [],
                    currentPrices: [])
    }()
    
    
    func testShoes() {
        let auntPearlUrl = "https://www.kicksonfire.com/app/nike-kd-12-aunt-pearl"
        XCTAssertEqual(auntPearlUrl, structWithL1Data.url)
        XCTAssertNotNil(structWithL1Data.hashValue)
        let undefeateUrl = "https://www.kicksonfire.com/app/undefeated-x-nike-air-max-90-black-solar-red"
        XCTAssertEqual(undefeateUrl, structWithL2Data.url)
        XCTAssertNotEqual(structWithL1Data, structWithL2Data)
        let copyL1 = structWithL1Data
        XCTAssertEqual(copyL1, structWithL1Data)
        XCTAssertNotEqual(copyL1, structWithL2Data)
        XCTAssertEqual(structWithL1Data.filename, Date().filenameDateString + "Nike KD 12 Aunt Pearl".hyphenated)
        XCTAssertTrue(structWithL2Data.hasL2Data)
        XCTAssertFalse(structWithL1Data.hasL2Data)
    }
}

extension String {
    var hyphenated: String {
        return self.lowercased().replacingOccurrences(of: " ", with: "-")
    }
}

extension Date {
    var filenameDateString: String {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        return String(format: "%d-%d-%d-", components.year!, components.month!, components.day!)
    }
}
