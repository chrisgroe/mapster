//
//  bfsTests.swift
//  mapsterTests
//
//  Created by Christian Gröling on 11.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation
import XCTest
@testable import mapster

class BreadthFirstSearchTests: XCTestCase {
    
    struct Node {
    }
    
    struct MockQueue : Queue {
        var popList : [GridPos] = []
        var pushDelegate : (_ element: GridPos) ->() = {x in
            return
        }
        
        func push(_ element: GridPos) {
            pushDelegate(element)
        }
        
        mutating func pop() -> GridPos? {
            guard popList.count != 0 else {
                return nil
            }
            return popList.removeFirst()
        }
    }
    
    
    class MockNavigatable : Navigatable {
        var testVector : [[GridPos]] =  []
        
        func getNeighbours(coords: GridPos) -> [GridPos] {
            guard testVector.count != 0 else {
                return []
            }
            return testVector.removeFirst()
        }
    }
    
    func test_search_noInjection() {
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [] // no neighbours
        
        var bfs = BreadthFirstSearch<GridPos, MockNavigatable, MockQueue>()
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        bfs.search(
            startPos: GridPos(x:0,y:0),
            navigation: mockNavigatable,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [])
    }
    
    func test_search_withSingleElement() {
        
        var pushList = [GridPos]()
        let mockQueue = MockQueue(
            popList: [GridPos(x:0, y:0)],
            pushDelegate: { x in
                pushList.append(x)
        })
        
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [] // no neighbours
        
        var bfs = BreadthFirstSearch<GridPos, MockNavigatable, MockQueue>(queue: mockQueue)
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        bfs.search(
            startPos: GridPos(x:0,y:0),
            navigation: mockNavigatable,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0)])
        XCTAssertEqual(pushList, [GridPos(x:0, y:0)])
    }
    
    func test_search_withLoop() {
        
        var pushList = [GridPos]()
        var mockQueue = MockQueue(
            popList: [GridPos(x:0, y:0)],
            pushDelegate: { x in
                pushList.append(x)
        })
        
        mockQueue.popList = [GridPos(x:0, y:0)]
        
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [[GridPos(x:0, y:0)]]
        
        var bfs = BreadthFirstSearch<GridPos, MockNavigatable, MockQueue>(queue: mockQueue)
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        bfs.search(
            startPos: GridPos(x:0,y:0),
            navigation: mockNavigatable,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0)])
        XCTAssertEqual(pushList, [GridPos(x:0, y:0)])
    }
    
    func test_search_with1NeighbourAndPopListIsEmpty() {
        
        var pushList = [GridPos]()
        var mockQueue = MockQueue(
            popList: [GridPos(x:0, y:0)],
            pushDelegate: { x in
                pushList.append(x)
        })
        mockQueue.popList = [GridPos(x:0, y:0)] // result of pop
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [[GridPos(x:1, y:0)]] // result of neighbor query
        
        var bfs = BreadthFirstSearch<GridPos, MockNavigatable, MockQueue>(queue: mockQueue)
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        bfs.search(
            startPos: GridPos(x:0,y:0),
            navigation: mockNavigatable,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0)]) // neighbor not on pop list
        XCTAssertEqual(pushList, [GridPos(x:0, y:0), GridPos(x:1, y:0)])
    }
    
    func test_search_with1NeighbourAndPopReturnsCorrectNeighbour() {
        
        var pushList = [GridPos]()
        let mockQueue = MockQueue(
            popList: [GridPos(x:0, y:0),GridPos(x:1, y:0)] ,
            pushDelegate: { x in
                pushList.append(x)
        })
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [[GridPos(x:1, y:0)]] // result of neighbor query
        
        var bfs = BreadthFirstSearch<GridPos, MockNavigatable, MockQueue>(queue: mockQueue)
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        bfs.search(
            startPos: GridPos(x:0,y:0),
            navigation: mockNavigatable,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0), GridPos(x:1, y:0)])
        XCTAssertEqual(pushList, [GridPos(x:0, y:0), GridPos(x:1, y:0)])
    }
    
    func test_search_with1NeighbourAndPopReturnsCorrectNeighbourAndLoop() {
        
        var pushList = [GridPos]()
        let mockQueue = MockQueue(
            popList: [GridPos(x:0, y:0), GridPos(x:1, y:0)] ,
            pushDelegate: { x in
                pushList.append(x)
        })
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [[GridPos(x:1, y:0), GridPos(x:0, y:0)]] // result of neighbor query
        
        var bfs = BreadthFirstSearch<GridPos, MockNavigatable, MockQueue>(queue: mockQueue)
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        bfs.search(
            startPos: GridPos(x:0,y:0),
            navigation: mockNavigatable,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0), GridPos(x:1, y:0)])
        XCTAssertEqual(pushList, [GridPos(x:0, y:0), GridPos(x:1, y:0)]) // Following element 0,0 is excluded!
    }
    
    
    
    
    
}


