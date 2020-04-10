//
//  StackTests.swift
//  mapsterTests
//
//  Created by Christian Gröling on 10.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation
import XCTest
@testable import mapster

class StackTests: XCTestCase {
    func test_init_withEmpty_shouldFirstNilAndCount0() {
        let stack = Stack<Int>()
        
        
        XCTAssertNil(stack.front)
        XCTAssertEqual(stack.count, 0)
    }
    
    func test_init_with3VariadicParameters_shouldFrontCorrectElementAndCount3() {
        let stack = Stack(10,11,12)

        XCTAssertEqual(stack.front, 12)
        XCTAssertEqual(stack.count, 3)
    }
    
    func test_init_withSequenceContaining3Elements_shouldFrontCorrectElementAndCount3() {
        let stack = Stack<Int>([10,11,12])

        XCTAssertEqual(stack.front, 12)
        XCTAssertEqual(stack.count, 3)
    }
    
    
    func test_push_with1Call_shouldFrontCorrectElementAndCount1() {
        let stack = Stack<Int>()
        stack.push(10)
        
        XCTAssertEqual(stack.front, 10)
        XCTAssertEqual(stack.count, 1)
    }
    
    func test_push_with2Calls_shouldFrontCorrectElementAndCount2() {
        let stack = Stack<Int>()
        stack.push(10)
        stack.push(11)
        
        XCTAssertEqual(stack.front, 11)
        XCTAssertEqual(stack.count, 2)
    }
    


    func test_pop_withEmptyStack_shouldReturnNil() {
        let stack = Stack<Int>()
        
        XCTAssertNil(stack.pop())
        XCTAssertEqual(stack.count, 0)
    }
    
    func test_pop_withStack3ElementsAnd4Calls_shouldReturnElementsInCorrectOrderAndNilAfterThat() {
        let stack = Stack(10,11,12)
        
        XCTAssertEqual(stack.pop(), 12)
        XCTAssertEqual(stack.pop(), 11)
        XCTAssertEqual(stack.pop(), 10)
        XCTAssertNil(stack.pop())
        XCTAssertEqual(stack.count, 0)
    }
    
}
