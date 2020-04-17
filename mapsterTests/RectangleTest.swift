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


class RectangleTest {
    struct MockTile {
        var ch : Character
    }
    func test_draw_symmetricalSquare() {
        var map = Map<MockTile>("""
        OOOOO
        OOOOO
        OOOOO
        OOOOO
        """) { (v, ch) in
            MockTile(ch:ch)
        }
    }
}
