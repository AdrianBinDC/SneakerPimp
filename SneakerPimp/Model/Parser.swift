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
        case images = "img.gallery-img"
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
        } catch {
            print(error)
        }
        
        return shoes
    }
    
    func parseL2Page(shoe: Shoe, html: String) -> Shoe {
        var shoe = shoe
        do {
            let doc = try SwiftSoup.parse(html)
            let images = try doc.select(ParserKeys.L2.images.rawValue)
                .map { imageElement in
                    try imageElement.attr("src").lowercased()
            }
            shoe.images = images
            
            let productDetails = try doc.select("div.product-details")
            
            let columnOne = try productDetails.select("div.col-md-6").first()
            let columnOneElements = try columnOne?.select("p")
            let wantString = try columnOneElements?.array()[1].text()
            let color = try columnOneElements?.array()[3].text()
            
            let columnTwo = try productDetails.select("div.col-md-6").last()
            let columnTwoElements = try columnTwo?.select("p")
            let styleCode = try columnTwoElements?.array()[1].text()
            let price = try columnTwoElements?.select("span").text()
            
            if let color = color {
                shoe.color = color
            }
            
            if let wantInt = wantString?.intValue {
                let want = Want(want: wantInt,
                                date: Date())
                if shoe.wants == nil {
                    shoe.wants = [want]
                } else {
                    shoe.wants?.append(want)
                }
            }
            
            if let styleCode = styleCode {
                shoe.styleCode = styleCode
            }
            
            if let price = price?.dropFirst(), let priceDouble = Double(price) {
                let priceStruct = Price(price: priceDouble, date: Date())
                
                if var retailPrices = shoe.retailPrices {
                    retailPrices.append(priceStruct)
                } else {
                    shoe.retailPrices = [priceStruct]
                }
                
                shoe.retailPrices?.append(priceStruct)
            }

        } catch {
            print(error)
        }
        
        return shoe
    }

}
