//
//  mapsterTests.swift
//  mapsterTests
//
//  Created by Christian Gröling on 09.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import XCTest
@testable import mapster

class MapTests: XCTestCase {

    func testInitXlen0AndYLen6IsNil () {

        
        let map = Map(0, 6)
        
        XCTAssertNil(map)
    }
    
    func testInitXlen6AndYLen0IsNil() {

        
        let map = Map(6, 0)
        
        XCTAssertNil(map)
    }
    
    func testInitXlenm6AndYLen6IsNil() {
        let map = Map(-6, 6)
        
        XCTAssertNil(map)
    }

    func testInitXlen5AndYLen6Isxlen5andylen6 () {
        let map = Map(5, 6)
        
        XCTAssertEqual(map?.xlen, 5)
        XCTAssertEqual(map?.ylen, 6)
    }

    
    func testSubscriptOfMap5p6InBonds () {
        let map = Map(2, 2)
        
        XCTAssertEqual(map?[0,0], Tile(x:0,y:0))
        XCTAssertEqual(map?[1,0], Tile(x:1,y:0))
        XCTAssertEqual(map?[0,1], Tile(x:0,y:1))
        XCTAssertEqual(map?[1,1], Tile(x:1,y:1))
    }

    func testSubscriptOfMap5p6OutOfBonds () {
        let map = Map(2, 2)
        
        XCTAssertNil(map?[-1,0])
        XCTAssertNil(map?[0,-1])
        XCTAssertNil(map?[-1,-1])
        XCTAssertNil(map?[2,0])
        XCTAssertNil(map?[0,2])
        XCTAssertNil(map?[2,2])
    }
}
