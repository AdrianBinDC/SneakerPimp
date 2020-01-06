//
//  StorageTests.swift
//  SneakerPimpTests
//
//  Created by Adrian Bolinger on 1/6/20.
//  Copyright © 2020 Adrian Bolinger. All rights reserved.
//

@testable import SneakerPimp
import XCTest

class StorageTests: XCTestCase {
    
    struct TestStruct: Codable {
        var integer: Int
        var float: Float
        var double: Double
        var bool: Bool
        var string: String
    }
    
    lazy var testStruct: TestStruct = {
        let test = TestStruct(integer: 1,
                              float: 2.0,
                              double: 3.00000000005,
                              bool: true,
                              string: "a random string")
        
        return test
    }()
    
    lazy var anotherTestStruct: TestStruct = {
        let test = TestStruct(integer: 1,
                              float: 2.0,
                              double: 3.00000000005,
                              bool: true,
                              string: "a random string")
        
        return test
    }()
    
    lazy var yetAnotherTestStruct: TestStruct = {
        let test = TestStruct(integer: 1,
                              float: 2.0,
                              double: 3.00000000005,
                              bool: true,
                              string: "a random string")
        
        return test
    }()
    
    private lazy var demoStructs: [TestStruct] = {
        return [testStruct, anotherTestStruct, yetAnotherTestStruct]
    }()
    
    func testStore() {
        let sutFilename = "sutStruct"
        // create the file
        Storage.store(testStruct, to: .documents, as: sutFilename)
        // create a duplicate file
        Storage.store(testStruct, to: .documents, as: sutFilename)
        // test that the file is stored in the proper location
        XCTAssertTrue(Storage.fileExists(sutFilename, in: .documents))
        XCTAssertFalse(Storage.fileExists(sutFilename, in: .caches))
        // delete the file
        Storage.remove(sutFilename, from: .documents)
        // delete it when it's already been deleted
        Storage.remove(sutFilename, from: .documents)
        // make sure it' deleted
        XCTAssertFalse(Storage.fileExists(sutFilename, in: .documents))
        // create it again
        var count = 0
        var demoStructFilenames: [String] = []
        demoStructs.forEach { demoStruct in
            let filename = sutFilename + String(count)
            Storage.store(demoStruct, to: .documents, as: filename)
            demoStructFilenames.append(filename)
            count += 1
        }
        // reset the count, as we're going to loop through it again below
        count = 0
        // ensure integrity of the retrieved file
        demoStructs.forEach { retrievedFile in
            if let retrievedFile = Storage.retrieve(demoStructFilenames[count], from: .documents, as: TestStruct.self) {
                XCTAssertEqual(retrievedFile.integer, 1)
                XCTAssertEqual(retrievedFile.float, 2.0)
                XCTAssertEqual(retrievedFile.double, 3.00000000005)
                XCTAssertEqual(retrievedFile.bool, true)
                XCTAssertEqual(retrievedFile.string, "a random string")
                count += 1
            }
        }
        count = 0
        // nuke 'em all
        Storage.clear(.documents)
        demoStructFilenames.forEach { filename in
            XCTAssertFalse(Storage.fileExists(filename, in: .documents))
        }
    }
    
}
