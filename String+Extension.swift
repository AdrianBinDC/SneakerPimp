//
//  String+Extension.swift
//  SneakerPimp
//
//  Created by Adrian Bolinger on 12/29/19.
//  Copyright © 2019 Adrian Bolinger. All rights reserved.
//

import Foundation

extension String {
    var kicksDate: Date {
        let formatter = DateFormatter()
        if self.contains(".") {
            formatter.dateFormat = "MMM. dd, yyyy"
        } else {
            formatter.dateFormat = "MMMM dd, yyyy"
        }
        
        return formatter.date(from: self) ?? Date()        
    }
    
    var intValue: Int? {
        return Int(self)
    }
}
