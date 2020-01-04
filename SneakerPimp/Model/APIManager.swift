//
//  APIManager.swift
//  SneakerHead
//
//  Created by Adrian Bolinger on 12/28/19.
//  Copyright © 2019 Adrian Bolinger. All rights reserved.
//

import Foundation
import SwiftSoup
import WebKit
import Combine

enum KicksOnFireURL: String {
    case baseUrl = "https://www.kicksonfire.com/app/"
    case releaseCalendar = "https://www.kicksonfire.com/app/upcoming"
}

class APIManager: ObservableObject {
    var shoesSubject = PassthroughSubject<[Shoe], Never>()
    private var webView: ScraperWebView!
    
    private var subscription = Set<AnyCancellable>()
    private var publisher: PassthroughSubject<String, Never>!
    
    init() {
        self.webView = ScraperWebView()
        self.publisher = webView.rawHTMLSubject
        
        publisher.sink { string in
            let parser = Parser()
            let parsedShoes = parser.parse(html: string)
            print("parsedShoes.count =", parsedShoes.count)
            self.shoesSubject.send(parsedShoes)
            self.shoesSubject.send(completion: .finished)
        }.store(in: &subscription)
    }
    
    func scrape(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
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
    
    // TODO: save url
}
