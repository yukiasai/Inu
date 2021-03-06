//
//  InuTests.swift
//  InuTests
//
//  Created by kingkong999yhirose on 2016/03/20.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import XCTest
@testable import Inu

class InuTests: XCTestCase, OnceType {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCall() {
        once.call() { }
        once.call() {
            XCTFail()
        }
    }
    
    func testCallWithKey() {
        let key = "key"
        once.call(key) { }
        once.call(key) {
            XCTFail()
        }
    }
    
    
    func testCall_CallWithKey_CallWithAny_CallAnyAndKey() {
        let expect = self.expectationWithDescription(__FUNCTION__)
        once.call() {
            expect.fulfill()
        }
        let expect2 = self.expectationWithDescription(__FUNCTION__)
        let key = "key"
        once.call(key) {
            expect2.fulfill()
        }
        
        wait()
    }
    
    func testCall_ClearAll_Call() {
        let key = "key"
        
        once.call() { }
        once.call(key) { }
        
        once.clearAll()
        
        let expect = self.expectationWithDescription(__FUNCTION__)
        once.call() {
            expect.fulfill()
        }
        let expect2 = self.expectationWithDescription(__FUNCTION__)
        once.call(key) {
            expect2.fulfill()
        }
        wait()
    }
    
    func testCallWithKey_ClearWithKey_CallWithKey() {
        let key = "key"
        once.call(key) { }
        once.clear(withKey: key)
        
        let expect = self.expectationWithDescription(__FUNCTION__)
        
        once.call(key) {
            expect.fulfill()
        }
        
        wait()
    }
    
    func testClearCondition() {
        let key = "key"
        
        once.call(key) { }
        once.clear() { $0 == key }
        
        let expect = self.expectationWithDescription(__FUNCTION__)
        
        once.call(key) {
            expect.fulfill()
        }
        
        wait()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func wait(timeout: NSTimeInterval = 0.1)
    {
        self.waitForExpectationsWithTimeout(timeout) { error in
            print("timeout error = \(error)")
        }
    }
}
