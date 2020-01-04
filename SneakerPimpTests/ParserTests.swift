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
    
    lazy var htmlSample: String = {
//        let bundle = Bundle.main
//        let path = bundle.path(forResource: "sampleHTML", ofType: "txt")
//        do {
//            let content = try String(contentsOf: URL(string: path!)!)
//            return content
//        } catch {
//            print(error)
//        }
        
        if let path = Bundle.main.path(forResource: "sampleHTML", ofType: "txt") {
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
    
    func testParser() {
        let parser = Parser()
        let shoes = parser.parse(html: htmlSample)
        XCTAssertEqual(shoes.count, 12)
    }

}
