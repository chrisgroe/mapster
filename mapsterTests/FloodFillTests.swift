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
    func test_floodfill_WithEmpty50x50Map() {
        let map = Map<MapTile>(50, 50, {p in
            MapTile(data: "O")
        })
        
        let resMap = map?.floodFill(MapPos(x: 5, y:5), factory: {p in MapTile(data: "X")})
        
        for x in 0..<10 {
            for y in 0..<10 {
                XCTAssertEqual(resMap![x,y]?.data, "X")
            }
        }
        
    }
    
    /*func test_floodfill_WithEmpty500x500Map() {
        let map = Map<MapTile>(500, 500, {p in
            MapTile(data: "O")
        })
        
        let resMap = map?.floodFill(MapPos(x: 5, y:5), factory: {p in MapTile(data: "X")})
        
        for x in 0..<10 {
            for y in 0..<10 {
                XCTAssertEqual(resMap![x,y]?.data, "X")
            }
        }
        
    }*/
    
    func test_floodfillPerfomance_WithEmpty50x50Maps() {
        self.measure {
            test_floodfill_WithEmpty50x50Map()
        }
            
    }
        
}

