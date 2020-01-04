//
//  ScraperWebViewTests.swift
//  SneakerPimpTests
//
//  Created by Adrian Bolinger on 12/30/19.
//  Copyright © 2019 Adrian Bolinger. All rights reserved.
//

@testable import SneakerPimp
import XCTest

class ScraperWebViewTests: XCTestCase {
    
    var userAgents: [String] = []
    
    var userAgentCountedSet: NSCountedSet {
        return NSCountedSet(array: userAgents)
    }
    
    func testUserAgent() {
        let numberOfIterations = 10
        var acceptableCount: ClosedRange<Int> {
            let minimum = Int(Double(numberOfIterations) * 0.5)
            let max = numberOfIterations
            
            return minimum...max
        }
        
        for _ in 0...numberOfIterations {
            webViewAssertions()
        }
        
        XCTAssertTrue(acceptableCount.contains(userAgentCountedSet.count))
    }
    
    private func webViewAssertions() {
        let webView = ScraperWebView()
        let userAgent = webView.customUserAgent!
        userAgents.append(userAgent)
        XCTAssertEqual(userAgent, webView.customUserAgent!)
        XCTAssertEqual(userAgent, webView.customUserAgent!)
    }
}
