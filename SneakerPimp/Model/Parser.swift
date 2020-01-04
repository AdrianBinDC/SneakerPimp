//
//  Parser.swift
//  SneakerPimp
//
//  Created by Adrian Bolinger on 12/29/19.
//  Copyright © 2019 Adrian Bolinger. All rights reserved.
//

import SwiftSoup

enum ParserKeys {
    enum L1: String {
        case shoeDiv = "div.release-date-item-wrapper"
        case shoeName = "div.release-date-title"
        case releaseDate = "div.event-date"
    }
    
    enum L2: String {
        case shoeDiv = "main"
        case releaseDate = "release date"
        case images = "li.lslide"
        case productDetails = "div.product-details"
        case attributeKey = "att-title"
        case attributeValue = "att-value"
        case releaseDescription = "release-description"
    }
}

enum PageType {
    case L1
    case L2
}

class Parser {
    func parseL1Page(html: String) -> [Shoe] {
        var shoes: [Shoe] = []
        
        do {
            let doc = try SwiftSoup.parse(html)
            let shoeDivs = try doc.select("div.release-date-item-wrapper")
            try shoeDivs.forEach { shoe in
                let shoeName = try shoe.select("div.release-date-title").first()?.text()
                let releaseDateString = try shoe.select("div.event-date").first()?.text()
                if let shoeName = shoeName,
                    let releaseDate = releaseDateString?.kicksDate {
                    let shoe = Shoe(name: shoeName,
                                    releaseDate: releaseDate,
                                    images: nil,
                                    wants: nil,
                                    color: nil,
                                    styleCode: nil,
                                    retailPrices: nil,
                                    currentPrices: nil)
                    shoes.append(shoe)
                }
            }
            print(doc)
        } catch {
            print(error)
        }
        
        return shoes
    }
}
