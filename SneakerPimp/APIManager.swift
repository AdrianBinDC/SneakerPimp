//
//  APIManager.swift
//  SneakerHead
//
//  Created by Adrian Bolinger on 12/28/19.
//  Copyright © 2019 Adrian Bolinger. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSoup

struct Price {
    let price: Double
    let date: Date
}

struct Want {
    let want: Int
    let date: Date
}

struct Shoe: Hashable {
    static func == (lhs: Shoe, rhs: Shoe) -> Bool {
        return lhs.name == rhs.name
            && lhs.releaseDate == rhs.releaseDate
            && lhs.color == rhs.color
            && lhs.style == rhs.style
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(releaseDate)
        hasher.combine(color)
        hasher.combine(style)
    }
        
    let name: String
    let releaseDate: Date
    let images: [UIImage]?
    let wants: [Want]?
    let color: String?
    let style: String?
    let retailPrices: [Price]?
    let currentPrices: [Price]?
    var url: String {
        let nameString = name.lowercased().replacingOccurrences(of: " ", with: "-")
        
        return KicksOnFireURL.baseUrl.rawValue + nameString
    }
    
}

enum KicksOnFireURL: String {
    case baseUrl = "https://www.kicksonfire.com/app/"
    case releaseCalendar = "https://www.kicksonfire.com/app/upcoming"
}

class APIManager {
        
    func urlFor(pageNumber: Int) -> String? {
        var components = URLComponents(string: KicksOnFireURL.releaseCalendar.rawValue)
        
        switch pageNumber {
        case 0:
            break
        default:
            components?.queryItems = [URLQueryItem(name: "page", value: String(pageNumber + 1))]
        }
        
        return components?.string
    }
    
    func urlFor(shoe: Shoe) {
        // TODO: implement
        // not final, work in progress

    }
    
    // TODO: get html for page
    // TODO: parse html
    // TODO: save url



}
