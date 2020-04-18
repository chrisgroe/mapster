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


class RectangleTest: XCTestCase {
    struct MockTile {
        var ch : Character
    }
    func test_draw_symmetricalSquare() {
        let map = Map<MockTile>("""
        OOOOO
        OOOOO
        OOOOO
        OOOOO
        OOOOO
        """) { (v, ch) in
            MockTile(ch:ch)
        }
        let actual = map.createStringView{
            map[$0].ch
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
}
