//
//  FloodFillTests.swift
//  mapsterTests
//
//  Created by Christian Gröling on 14.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation
import XCTest
@testable import mapster

class FloodFillTests: XCTestCase {
    func test_floodfill_withEmpty100x100Map() {
        let map = Map<MapTile>(100, 100, {p in
            MapTile(data: "O")
        })
        
        let resMap = map?.floodFill(MapPos(x: 50, y:50)) {p in MapTile(data: "X")}
        
        for x in 0..<100 {
            for y in 0..<100 {
                XCTAssertEqual(resMap?[x,y].data, "X")
            }
        }
        
    }

    func test_floodfill_withEmpty100x100MapAndHalfBlocked() {
        var map = Map<MapTile>(100, 100, {p in
            MapTile(data: "O")
        })
        map?.isBlocked = {p in
            if p.x>=50 {
                return true
            }
            return false
        }
        let resMap = map?.floodFill(MapPos(x: 25, y:50)) {p in MapTile(data: "X")}
        
        for x in 0..<50 {
            for y in 0..<100 {
                XCTAssertEqual(resMap?[x,y].data, "X")
            }
        }
        
        for x in 50..<100 {
            for y in 0..<100 {
                XCTAssertEqual(resMap?[x,y].data, "O", "x:\(x) y:\(y)")
            }
        }
    }

    
    func test_floodfillPerfomance_withEmpty100x100Maps() {
        self.measure {
            test_floodfill_withEmpty100x100Map()
        }
            
    }
        
}

