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
import Disk

enum KicksOnFireURL: String {
    case baseUrl = "https://www.kicksonfire.com/app/"
    case releaseCalendar = "https://www.kicksonfire.com/app/upcoming"
}

class APIManager: ObservableObject {
    
    enum Page {
        case L1(pageNumber: Int?)
        case L2(shoeURL: String)
    }
    
    var shoesSubject = PassthroughSubject<[Shoe], Never>()
    private var webView: ScraperWebView!
    
    private var subscription = Set<AnyCancellable>()
    private var publisher: PassthroughSubject<String, Never>!
    
    init() {
        self.webView = ScraperWebView()
        self.publisher = webView.rawHTMLSubject
        
        publisher.sink { string in
            let parser = Parser()
            let parsedShoes = parser.parseL1Page(html: string)
            self.save(shoes: parsedShoes)
        }.store(in: &subscription)
    }
    
    func scrape(page: Page) {
        var url: URL
        switch page {
        case .L1(let pageNumber):
            guard let urlString = urlFor(pageNumber: pageNumber ?? 0) else { return }
            url = URL(string: urlString)!
        case .L2(let shoeURL):
            url = URL(string: shoeURL)!
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
    
    func save(shoes: [Shoe]) {
        // FIXME: data does not persist
        shoes.forEach { shoe in
            print(Storage.fileExists(String(shoe.hashValue), in: .documents))
            if !Storage.fileExists(String(shoe.hashValue), in: .documents) {
                Storage.store(shoe, to: .documents, as: String(shoe.hashValue))
            }
        }
    }
        
    // TODO: save url
}
