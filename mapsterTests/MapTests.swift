//
//  MapTests.swift
//  MapTests
//
//  Created by Christian Gröling on 09.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import XCTest
@testable import mapster




class MapTests: XCTestCase {

    struct MockTile: Equatable {
        let x : Int
        let y : Int
        let ch : Character
        
        init(x: Int, y:Int) {
            self.init(x:x, y:y, ch:"O")
        }
        init(x: Int, y:Int, ch:Character) {
            self.x = x
            self.y = y
            self.ch = ch
        }
    }
    
    func testInitXlen0AndYLen6IsNil () {
        let map = Map(0, 6, {x,y in
            MockTile(x:x,y:y)
        })
        
        XCTAssertNil(map)
    }
    
    func testInitXlen6AndYLen0IsNil() {
        let map = Map(6, 0, {x,y in
            MockTile(x:x,y:y)
        })
        
        XCTAssertNil(map)
    }
    
    func testInitXlenm6AndYLen6IsNil() {
        let map = Map(-6, 6, {x,y in
            MockTile(x:x,y:y)
        })
        
        XCTAssertNil(map)
    }

    func testInitXlen5AndYLen6Isxlen5andylen6 () {
        let map = Map(5, 6, {x,y in
            MockTile(x:x,y:y)
        })
        
        XCTAssertEqual(map?.xlen, 5)
        XCTAssertEqual(map?.ylen, 6)
    }

    
    func testSubscriptOfMap5p6InBonds () {
        let map = Map(2, 2, {x,y in
            MockTile(x:x,y:y)
        })
        
        XCTAssertEqual(map?[0,0], MockTile(x:0,y:0))
        XCTAssertEqual(map?[1,0], MockTile(x:1,y:0))
        XCTAssertEqual(map?[0,1], MockTile(x:0,y:1))
        XCTAssertEqual(map?[1,1], MockTile(x:1,y:1))
    }

    func testSubscriptOfMap5p6OutOfBonds () {
        let map = Map(2, 2, {x,y in
            MockTile(x:x,y:y)
        })
        
        XCTAssertNil(map?[-1,0])
        XCTAssertNil(map?[0,-1])
        XCTAssertNil(map?[-1,-1])
        XCTAssertNil(map?[2,0])
        XCTAssertNil(map?[0,2])
        XCTAssertNil(map?[2,2])
    }
    
    func testInitWithString () {

        let mapstr = """
        ..
        .X
        """
        let map = Map(mapstr, {x,y,ch in
            MockTile(x:x, y:y, ch:ch)
        })
        
        XCTAssertEqual(map?.xlen, 2)
        XCTAssertEqual(map?.ylen, 2)
        
        XCTAssertEqual(map?[0,0], MockTile(x:0,y:0,ch: "."))
        XCTAssertEqual(map?[1,0], MockTile(x:1,y:0,ch: "."))
        XCTAssertEqual(map?[0,1], MockTile(x:0,y:1,ch: "."))
        XCTAssertEqual(map?[1,1], MockTile(x:1,y:1,ch: "X"))
    }
}
