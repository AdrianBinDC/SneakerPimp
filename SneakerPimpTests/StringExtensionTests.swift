//
//  StringExtensionTests.swift
//  SneakerPimpTests
//
//  Created by Adrian Bolinger on 12/29/19.
//  Copyright © 2019 Adrian Bolinger. All rights reserved.
//

@testable import SneakerPimp
import XCTest

class StringExtensionTests: XCTestCase {
    
    enum dateFormat: String {
        case mmddyyyy = "MM-dd-yyyy"
    }
    
    private func createDate(year: Int, month: Int, day: Int) -> Date {
//        var components = DateComponents()
//        components.timeZone = Calendar.current.timeZone
//        components.year = year
//        components.month = month
//        components.day = day
        let dateComponents = DateComponents(calendar: Calendar.current, timeZone: Calendar.current.timeZone, era: nil, year: year, month: month, day: day, hour: 0, minute: 0, second: 0, nanosecond: 0, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)

        return Calendar.current.date(from: dateComponents) ?? Date()
    }
    
    private func create(date: String) -> Date {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.date(from: date) ?? Date()
    }

    func testStringDateWithPeriod() {
        let sampleText = "Dec. 28, 2019"
        let desiredDate = createDate(year: 2019, month: 12, day: 28)
        XCTAssertEqual(sampleText.kicksDate, desiredDate)
    }
    
    func testStringDateWithoutPeriod() {
        let sampleText = "June 28, 2019"
        let desiredDate = createDate(year: 2019, month: 6, day: 28)
        XCTAssertEqual(sampleText.kicksDate, desiredDate)
    }

}
