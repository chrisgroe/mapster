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
    
    func iteratorToArray(_ it : Map<MockTile>.NeighborIterator) -> [MapPos] {
        var ar = [MapPos]()
        while let i = it.next() {
            ar.append(i)
        }
        return ar
    }
    
    func test_init_withXlen0AndYLen6_shouldReturnNil () {
        let map = Map(0, 6, {pos in
            MockTile(x:pos.x,y:pos.y)
        })
        
        XCTAssertNil(map)
    }
    
    func test_init_withXlen6AndYLen0_shouldReturnNil() {
        let map = Map(6, 0, {pos in
            MockTile(x:pos.x,y:pos.y)
        })
        
        XCTAssertNil(map)
    }
    
    func test_init_withXlenMinus6AndYLen6_shouldReturnNil() {
        let map = Map(-6, 6, {pos in
            MockTile(x:pos.x,y:pos.y)
        })
        
        XCTAssertNil(map)
    }

    func test_init_withXlen5AndYLen6_shouldReturnObjectWithSize5x6 () {
        let map = Map(5, 6, {pos in
            MockTile(x:pos.x,y:pos.y)
        })
        
        XCTAssertEqual(map?.xlen, 5)
        XCTAssertEqual(map?.ylen, 6)
    }

    
    func test_subscriptGet_withMap2x2AndValidAccess_shouldReturnValue () {
        let map = Map(2, 2, {pos in
            MockTile(x:pos.x,y:pos.y)
        })
        
        XCTAssertEqual(map?[0,0], MockTile(x:0,y:0))
        XCTAssertEqual(map?[1,0], MockTile(x:1,y:0))
        XCTAssertEqual(map?[0,1], MockTile(x:0,y:1))
        XCTAssertEqual(map?[1,1], MockTile(x:1,y:1))
    }

    
    func test_subscriptSet_withMap2x2SetAllIndices_shouldReturnCorrectArray () {
        var map = Map(2, 2, {pos in
            MockTile(x:pos.x,y:pos.y)
        })
        
        map?[0,0] = MockTile(x:0,y:0,ch:"A")
        map?[1,0] = MockTile(x:1,y:0,ch:"B")
        map?[0,1] = MockTile(x:0,y:1,ch:"C")
        map?[1,1] = MockTile(x:1,y:1,ch:"D")
        
        XCTAssertEqual(map?[0,0], MockTile(x:0,y:0,ch: "A"))
        XCTAssertEqual(map?[1,0], MockTile(x:1,y:0,ch: "B"))
        XCTAssertEqual(map?[0,1], MockTile(x:0,y:1,ch: "C"))
        XCTAssertEqual(map?[1,1], MockTile(x:1,y:1,ch: "D"))
    }
    
    
    func test_init_withString_shouldReturnCorrectMap () {

        let mapstr = """
        ..
        .X
        """
        let map = Map(mapstr, {pos, ch in
            MockTile(x:pos.x,y:pos.y, ch:ch)
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
    
    func test_getEdges_with1x1Map_shouldReturnEmptyList () {
        let map = Map(1, 1, {pos in
            MockTile(x:pos.x,y:pos.y)
        })
        
        let res = map!.getNeighbors(of: MapPos(x:0,y:0))
        
        XCTAssertEqual(iteratorToArray(res), [])
    }
    func test_getEdges_with1x1MapOutOfBoundAccess_shouldReturnEmptyList () {
        let map = Map(1, 1, {pos in
            MockTile(x:pos.x,y:pos.y)
        })
        
        let res = map!.getNeighbors(of: MapPos(x:1,y:1))
        
        XCTAssertEqual(iteratorToArray(res), [])
    }
    
    func test_getEdges_with2x2Map () {
        let map = Map(2, 2, {pos in
            MockTile(x:pos.x,y:pos.y)
        })
        
        let res00 = map!.getNeighbors(of: MapPos(x:0,y:0))
        let res10 = map!.getNeighbors(of: MapPos(x:1,y:0))
        let res01 = map!.getNeighbors(of: MapPos(x:0,y:1))
        let res11 = map!.getNeighbors(of: MapPos(x:1,y:1))
        
        //           4 (y-1)
        //           |
        // (x-1) 3 - X - 1 (x+1)
        //           |
        //           2 (y+1)
        
        XCTAssertEqual(iteratorToArray(res00), [MapPos(x:1,y:0), MapPos(x:0,y:1)])
        XCTAssertEqual(iteratorToArray(res10), [MapPos(x:1,y:1), MapPos(x:0,y:0)])
        XCTAssertEqual(iteratorToArray(res01), [MapPos(x:1,y:1), MapPos(x:0,y:0)])
        XCTAssertEqual(iteratorToArray(res11), [MapPos(x:0,y:1), MapPos(x:1,y:0)])
    }
    
    func test_getEdges_with3x3MapMid () {
        let map = Map(3, 3, {pos in
            MockTile(x:pos.x,y:pos.y)
        })
        
        let res11 = map!.getNeighbors(of: MapPos(x:1,y:1))
        
        //           4 (y-1)
        //           |
        // (x-1) 3 - X - 1 (x+1)
        //           |
        //           2 (y+1)
        
        XCTAssertEqual(iteratorToArray(res11), [MapPos(x:2,y:1), MapPos(x:1,y:2), MapPos(x:0,y:1), MapPos(x:1,y:0)])
    }
    
    
}
