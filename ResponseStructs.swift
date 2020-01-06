//
//  ResponseStructs.swift
//  SneakerPimp
//
//  Created by Adrian Bolinger on 1/1/20.
//  Copyright © 2020 Adrian Bolinger. All rights reserved.
//

import Foundation

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
            && lhs.color == rhs.color
            && lhs.styleCode == rhs.styleCode
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(releaseDate)
        hasher.combine(color)
        hasher.combine(styleCode)
    }
    
    let name: String
    let releaseDate: Date
    var images: [String]? // done
    var wants: [Want]?
    var color: String?
    var styleCode: String?
    var retailPrices: [Price]?
    let currentPrices: [Price]?
}

extension Shoe {
    public var url: String {
        return KicksOnFireURL.baseUrl.rawValue + hyphenatedName
    }
    
    public var hasL2Data: Bool {
        return wants != nil
    }
    
    private var hyphenatedName: String {
        return name.lowercased().replacingOccurrences(of: " ", with: "-")
    }
    
    public var filename: String {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: releaseDate)
        let dateString = String(format: "%d-%d-%d-", components.year!, components.month!, components.day!)
        
        return dateString + hyphenatedName
    }
}
