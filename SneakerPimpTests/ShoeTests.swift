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
    func testShoes() {
        let auntPearl = "https://www.kicksonfire.com/app/nike-kd-12-aunt-pearl"
        
        let auntPearlStruct = Shoe(name: "Nike KD 12 Aunt Pearl", releaseDate: Date(), images: nil, wants: [], color: nil, styleCode: "", retailPrices: [], currentPrices: [])
        XCTAssertEqual(auntPearl, auntPearlStruct.url)
        
        let undefeated = "https://www.kicksonfire.com/app/undefeated-x-nike-air-max-90-black-solar-red"
        let undefeatedStruct = Shoe(name: "Undefeated x Nike Air Max 90 Black Solar Red", releaseDate: Date(), images: nil, wants: [], color: nil, styleCode: "", retailPrices: [], currentPrices: [])
        XCTAssertEqual(undefeated, undefeatedStruct.url)
    }
}
