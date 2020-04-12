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
    
    func test_init_withXlen0AndYLen6_shouldReturnNil () {
        let map = Map(0, 6, {x,y in
            MockTile(x:x,y:y)
        })
        
        XCTAssertNil(map)
    }
    
    func test_init_withXlen6AndYLen0_shouldReturnNil() {
        let map = Map(6, 0, {x,y in
            MockTile(x:x,y:y)
        })
        
        XCTAssertNil(map)
    }
    
    func test_init_withXlenMinus6AndYLen6_shouldReturnNil() {
        let map = Map(-6, 6, {x,y in
            MockTile(x:x,y:y)
        })
        
        XCTAssertNil(map)
    }

    func test_init_withXlen5AndYLen6_shouldReturnObjectWithSize5x6 () {
        let map = Map(5, 6, {x,y in
            MockTile(x:x,y:y)
        })
        
        XCTAssertEqual(map?.xlen, 5)
        XCTAssertEqual(map?.ylen, 6)
    }

    
    func test_subscript_withMap2x2AndValidAccess_shouldReturnValue () {
        let map = Map(2, 2, {x,y in
            MockTile(x:x,y:y)
        })
        
        XCTAssertEqual(map?[0,0], MockTile(x:0,y:0))
        XCTAssertEqual(map?[1,0], MockTile(x:1,y:0))
        XCTAssertEqual(map?[0,1], MockTile(x:0,y:1))
        XCTAssertEqual(map?[1,1], MockTile(x:1,y:1))
    }

    func test_subscript_withMap2x2AndOutOfBoundAccess_shouldReturnNil () {
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
    
    func test_init_withString_shouldReturnCorrectMap () {

        let mapstr = """
        ..
        .X
        """
        let map = Map(mapstr, {x,y,ch in
            MockTile(x:x, y:y, ch:ch)
        })
        
        XCTAssertEqual(map?.xlen, 2)
        XCTAssertEqual(map?.ylen, 2)
        
        // y
        //x =01
        // =
        // 0 ..
        // 1 .X
        XCTAssertEqual(map?[0,0], MockTile(x:0,y:0,ch: "."))
        XCTAssertEqual(map?[1,0], MockTile(x:1,y:0,ch: "."))
        XCTAssertEqual(map?[0,1], MockTile(x:0,y:1,ch: "."))
        XCTAssertEqual(map?[1,1], MockTile(x:1,y:1,ch: "X"))
    }
    
    func test_getNeighbours_with1x1Map_shouldReturnEmptyList () {
        let map = Map(1, 1, {x,y in
            MockTile(x:x,y:y)
        })
        
        let res = map?.getNeighbours(coords: GridPos(x:0,y:0))
        
        XCTAssertEqual(res, [])
    }
    func test_getNeighbours_with1x1MapOutOfBoundAccess_shouldReturnEmptyList () {
        let map = Map(1, 1, {x,y in
            MockTile(x:x,y:y)
        })
        
        let res = map?.getNeighbours(coords: GridPos(x:1,y:1))
        
        XCTAssertEqual(res, [])
    }
    
    func test_getNeighbours_with2x2Map () {
        let map = Map(2, 2, {x,y in
            MockTile(x:x,y:y)
        })
        
        let res00 = map?.getNeighbours(coords: GridPos(x:0,y:0))
        let res10 = map?.getNeighbours(coords: GridPos(x:1,y:0))
        let res01 = map?.getNeighbours(coords: GridPos(x:0,y:1))
        let res11 = map?.getNeighbours(coords: GridPos(x:1,y:1))
        
        //           4 (y-1)
        //           |
        // (x-1) 3 - X - 1 (x+1)
        //           |
        //           2 (y+1)
        
        XCTAssertEqual(res00, [GridPos(x:1,y:0), GridPos(x:0,y:1)])
        XCTAssertEqual(res10, [GridPos(x:1,y:1), GridPos(x:0,y:0)])
        XCTAssertEqual(res01, [GridPos(x:1,y:1), GridPos(x:0,y:0)])
        XCTAssertEqual(res11, [GridPos(x:0,y:1), GridPos(x:1,y:0)])
    }
    
    func test_getNeighbours_with3x3MapMid () {
        let map = Map(3, 3, {x,y in
            MockTile(x:x,y:y)
        })
        
        let res11 = map?.getNeighbours(coords: GridPos(x:1,y:1))
        
        //           4 (y-1)
        //           |
        // (x-1) 3 - X - 1 (x+1)
        //           |
        //           2 (y+1)
        
        XCTAssertEqual(res11, [GridPos(x:2,y:1), GridPos(x:1,y:2), GridPos(x:0,y:1), GridPos(x:1,y:0)])
    }
    
    
}
