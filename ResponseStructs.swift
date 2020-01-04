//
//  ResponseStructs.swift
//  SneakerPimp
//
//  Created by Adrian Bolinger on 1/1/20.
//  Copyright © 2020 Adrian Bolinger. All rights reserved.
//

import UIKit

struct Price: Codable {
    let price: Double
    let date: Date
}

struct Want: Codable {
    let want: Int
    let date: Date
}

struct Shoe: Codable, Hashable {
    static func == (lhs: Shoe, rhs: Shoe) -> Bool {
        return lhs.name == rhs.name
            && lhs.releaseDate == rhs.releaseDate
            && lhs.url == rhs.url
            && lhs.color == rhs.color
            && lhs.style == rhs.style
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(releaseDate)
        hasher.combine(url)
        hasher.combine(color)
        hasher.combine(style)
    }
    
    let name: String
    let releaseDate: Date
    let url: String
    let images: [String]?
    let wants: [Want]?
    let color: String?
    let style: String?
    let retailPrices: [Price]?
    let currentPrices: [Price]?
}
