//
//  ParserTests.swift
//  SneakerPimpTests
//
//  Created by Adrian Bolinger on 12/29/19.
//  Copyright © 2019 Adrian Bolinger. All rights reserved.
//

import XCTest
@testable import SneakerPimp

class ParserTests: XCTestCase {
    
    lazy var l1Sample: String = {        
        if let path = Bundle.main.path(forResource: "L1", ofType: "html") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl)
                let string = String(data: data, encoding: .utf8)
                return string!
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return ""
    }()
    
    lazy var l2Sample: String = {
        if let path = Bundle.main.path(forResource: "L2", ofType: "html") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl)
                let string = String(data: data, encoding: .utf8)
                return string!
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return ""
    }()
    
    
    func testL1Sample() {
        let parser = Parser()
        let shoes = parser.parseL1Page(html: l1Sample)
        XCTAssertEqual(shoes.count, 12)
    }
    
    func testL1ParseSpeed() {
        measure {
            let parser = Parser()
            let shoes = parser.parseL1Page(html: l1Sample)
        }
    }
    
    func testL2Sample() {
        let parser = Parser()
        let testShoe = Shoe(name: "Air Jordan 3 GS Barely Grape",
                            releaseDate: Date(),
                            images: nil,
                            wants: nil,
                            color: nil,
                            styleCode: nil,
                            retailPrices: nil,
                            currentPrices: nil)
        let shoe = parser.parseL2Page(shoe: testShoe, html: l2Sample)
        XCTAssertEqual(shoe.images?.count, 5)
        XCTAssertEqual(shoe.name, "Air Jordan 3 GS Barely Grape")
        XCTAssertEqual(shoe.wants?[0].want, 713)
        XCTAssertEqual(shoe.color, "Barely Grape/Hyper Crimson-Fire Pink")
        XCTAssertEqual(shoe.styleCode, "441140-500")
        XCTAssertEqual(shoe.retailPrices?[0].price, 140.0)
    }
    
    func testL2ParseSpeed() {
        measure {
            let parser = Parser()
            let testShoe = Shoe(name: "Air Jordan 3 GS Barely Grape",
                                releaseDate: Date(),
                                images: nil,
                                wants: nil,
                                color: nil,
                                styleCode: nil,
                                retailPrices: nil,
                                currentPrices: nil)
            let shoe = parser.parseL2Page(shoe: testShoe, html: l2Sample)
            
        }
    }
    
}
