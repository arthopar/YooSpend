//
//  YooSpendTests.swift
//  YooSpendTests
//
//  Created by Artak on 12/23/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import XCTest
@testable import YooSpend

class YooSpendTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let json = """
{
 "name": "Federico Zanetello"
}
""".data(using: .utf8)!
        // let data = Data(base64Encoded: string)
        let parser = Parser()
        do {
            let a: TestModel = try parser.parsData(data: json)
            print(a)
        } catch {
            print(error)
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
