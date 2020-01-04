//
//  Parser.swift
//  SneakerPimp
//
//  Created by Adrian Bolinger on 12/29/19.
//  Copyright © 2019 Adrian Bolinger. All rights reserved.
//

import SwiftSoup

class Parser {
    func parse(html: String) -> [Shoe] {
        var shoes: [Shoe] = []
        
        do {
            let doc = try SwiftSoup.parse(html)
            let shoeDivs = try doc.select("div.release-date-item-wrapper")
            try shoeDivs.forEach { shoe in
                let shoeUrl = try shoe.select("div.release-date-item-wrapper").first()?.text()
                let shoeName = try shoe.select("div.release-date-title").first()?.text()
                let releaseDateString = try shoe.select("div.event-date").first()?.text()
                if let shoeName = shoeName,
                    let releaseDate = releaseDateString?.kicksDate,
                    let url = shoeUrl {
                    let shoe = Shoe(name: shoeName,
                                    releaseDate: releaseDate,
                                    url: url,
                                    images: nil,
                                    wants: nil,
                                    color: nil,
                                    style: nil,
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
