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
    func test_floodfill_WithEmpty100x100Map() {
        let map = Map<MapTile>(100, 100, {p in
            MapTile(data: "O")
        })
        
        let resMap = map?.floodFill(MapPos(x: 5, y:5), factory: {p in MapTile(data: "X")})
        
        for x in 0..<100 {
            for y in 0..<100 {
                XCTAssertEqual(resMap![x,y]?.data, "X")
            }
        }
        
    }
    
    func test_floodfillPerfomance_WithEmpty100x100Maps() {
        self.measure {
            test_floodfill_WithEmpty100x100Map()
        }
            
    }
        
}

