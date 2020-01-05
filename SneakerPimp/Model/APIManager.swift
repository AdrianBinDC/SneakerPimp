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
    
    enum Page {
        case L1(pageNumber: Int?)
        case L2(shoeURL: String)
    }
    
    var shoesSubject = PassthroughSubject<[Shoe], Never>()
    /*
     The webview grabs HTML and publishes it. When the subscriber receives it, the data is parsed.
     */
    private var l1WebView: ScraperWebView!
    private var l1Subscription = Set<AnyCancellable>()
    private var l1Publisher: PassthroughSubject<String, Never>!
    
    public var shoePublisher = PassthroughSubject<[Shoe], Never>()
    
    init() {
        self.l1WebView = ScraperWebView()
        self.l1Publisher = l1WebView.rawHTMLSubject
        
        l1Publisher.sink { string in
            let parser = Parser()
            let parsedShoes = parser.parseL1Page(html: string)
            self.shoePublisher.send(parsedShoes)
        }.store(in: &l1Subscription)
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
        
        l1WebView.load(URLRequest(url: url))
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
    
//    func save(shoes: [Shoe]) {
//        // FIXME: data does not persist
//        shoes.forEach { shoe in
//            print(Storage.fileExists(String(shoe.hashValue), in: .documents))
//            if !Storage.fileExists(String(shoe.hashValue), in: .documents) {
//                Storage.store(shoe, to: .documents, as: String(shoe.hashValue))
//            }
//        }
//    }
        
    // TODO: save url
}
