//
//  RectangleTest.swift
//  mapsterTests
//
//  Created by Christian Gröling on 17.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation
import XCTest
@testable import mapster


class RadialShapeTests: XCTestCase {
    struct MockTile {
        var ch : Character
    }
    func test_draw_symmetricalSquareLength1() {
        let map = Map<MockTile>("""
        OOOOO
        OOOOO
        OOOOO
        OOOOO
        OOOOO
        """) { (v, ch) in
            MockTile(ch:ch)
        }
        
        let square = SquareShape<MockTile>(MapPos(x: 2, y: 2), 1)
        let resultMap = square.draw(map: map, transform: {
            pos in
            MockTile(ch: "X")
        })
        let actual = resultMap.createStringView{
            $0.ch
        }
        
        let expected = """
        OOOOO
        OOOOO
        OOXOO
        OOOOO
        OOOOO
        """
        XCTAssertEqual(actual, expected)
    }
    
    func test_draw_symmetricalSquareLength2() {
        let map = Map<MockTile>("""
        OOOOO
        OOOOO
        OOOOO
        OOOOO
        OOOOO
        """) { (v, ch) in
            MockTile(ch:ch)
        }
        
        let square = SquareShape<MockTile>(MapPos(x: 2, y: 2), 2)
        let resultMap = square.draw(map: map, transform: {
            pos in
            MockTile(ch: "X")
        })
        let actual = resultMap.createStringView{
            $0.ch
        }
        
        let expected = """
        OOOOO
        OXXXO
        OXXXO
        OXXXO
        OOOOO
        """
        XCTAssertEqual(actual, expected)
    }
    
    func test_draw_symmetricalSquareLength3() {
        let map = Map<MockTile>("""
           OOOOOO
           OOOOOO
           OOOOOO
           OOOOOO
           OOOOOO
           OOOOOO
           """) { (v, ch) in
            MockTile(ch:ch)
        }
        
        let square = SquareShape<MockTile>(MapPos(x: 2, y: 2), 3)
        let resultMap = square.draw(map: map, transform: {
            pos in
            MockTile(ch: "X")
        })
        let actual = resultMap.createStringView{
            $0.ch
        }
        
        let expected = """
           XXXXXO
           XXXXXO
           XXXXXO
           XXXXXO
           XXXXXO
           OOOOOO
           """
        XCTAssertEqual(actual, expected)
    }
    
    func test_draw_asymmetricalSquareLength2() {
        let map = Map<MockTile>("""
        OOOOO
        OOOOO
        OOOOO
        OOOOO
        OOOOO
        """) { (v, ch) in
            MockTile(ch:ch)
        }
        
        let square = SquareShape<MockTile>(MapPos(x: 1, y: 1), 2)
        let resultMap = square.draw(map: map, transform: {
            pos in
            MockTile(ch: "X")
        })
        let actual = resultMap.createStringView{
            $0.ch
        }
        
        let expected = """
        XXXOO
        XXXOO
        XXXOO
        OOOOO
        OOOOO
        """
        XCTAssertEqual(actual, expected)
    }
    
    func test_draw_circleRadius3() {
        let map = Map<MockTile>("""
        OOOOOOO
        OOOOOOO
        OOOOOOO
        OOOOOOO
        OOOOOOO
        OOOOOOO
        OOOOOOO
        """) { (v, ch) in
            MockTile(ch:ch)
        }
        
        let square = CircleShape<MockTile>(MapPos(x: 3, y: 3), 2.0)
        let resultMap = square.draw(map: map, transform: {
            pos in
            MockTile(ch: "X")
        })
        let actual = resultMap.createStringView{
            $0.ch
        }
        
        let expected = """
        OOOOOOO
        OOOXOOO
        OOXXXOO
        OXXXXXO
        OOXXXOO
        OOOXOOO
        OOOOOOO
        """
        XCTAssertEqual(actual, expected)
    }
    
}
