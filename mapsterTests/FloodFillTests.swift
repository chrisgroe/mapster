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
        
        let resMap = map.floodFill(
            pos: MapPos(x: 50, y:50),
            visitor: {p in MapTile(data: "X")}
        )
        
        for x in 0..<100 {
            for y in 0..<100 {
                XCTAssertEqual(resMap[x,y].data, "X")
            }
        }
        
    }

    func test_floodfill_withEmpty100x100MapAndHalfBlocked() {
        let map = Map<MapTile>(100, 100, {p in
            MapTile(data: "O")
        })

        let resMap = map.floodFill(
            pos: MapPos(x: 25, y:50),
            visitor: {p in MapTile(data: "X")},
            isBlocked: {p in
                if p.x>=50 {
                    return true
                }
                return false
            }
        )

        var expected = Array(repeating: Array<Character>(repeating: ".", count: 100), count: 100)
        var actual = Array(repeating: Array<Character>(repeating: ".", count: 100), count: 100)

        for x in 0..<50 {
            for y in 0..<100 {
                expected[x][y] = "X"
                actual[x][y] = resMap[x,y].data
            }
        }
        
        for x in 50..<100 {
            for y in 0..<100 {
                expected[x][y] = "O"
                actual[x][y] = resMap[x,y].data
            }
        }
        XCTAssertEqual(actual, expected)


    }

    
    func test_floodfillPerfomance_withEmpty100x100Maps() {
        self.measure {
            test_floodfill_withEmpty100x100Map()
        }
            
    }
        
}

