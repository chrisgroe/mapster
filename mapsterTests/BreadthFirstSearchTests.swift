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
    
    class MockQueue : Queue {
        var popList : [GridPos] = []
        var pushDelegate : (_ element: GridPos) ->() = {x in
            return
        }
        
        required init() {
        }
        
        init(popList : [GridPos], pushDelegate : @escaping  (_ element: GridPos) ->()) {
            self.popList = popList
            self.pushDelegate = pushDelegate
        }
        
        func push(_ element: GridPos) {
            pushDelegate(element)
        }
        
        func pop() -> GridPos? {
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
    
    struct MockBreadthFirstSearchTraits : BreadthFirstSearchTraits {
        typealias Element = GridPos
        typealias Nav = MockNavigatable
        typealias Q = MockQueue
    }
    
    func test_search_noInjection() {
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [] // no neighbours
        
        let bfs = BreadthFirstSearch<MockBreadthFirstSearchTraits>()
        
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
        
        let bfs = BreadthFirstSearch<MockBreadthFirstSearchTraits>(queue: mockQueue)
        
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
        let mockQueue = MockQueue(
            popList: [GridPos(x:0, y:0)],
            pushDelegate: { x in
                pushList.append(x)
        })
        
        mockQueue.popList = [GridPos(x:0, y:0)]
        
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [[GridPos(x:0, y:0)]]
        
        let bfs = BreadthFirstSearch<MockBreadthFirstSearchTraits>(queue: mockQueue)
        
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
        let mockQueue = MockQueue(
            popList: [GridPos(x:0, y:0)],
            pushDelegate: { x in
                pushList.append(x)
        })
        mockQueue.popList = [GridPos(x:0, y:0)] // result of pop
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [[GridPos(x:1, y:0)]] // result of neighbor query
        
        let bfs = BreadthFirstSearch<MockBreadthFirstSearchTraits>(queue: mockQueue)
        
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
        
        let bfs = BreadthFirstSearch<MockBreadthFirstSearchTraits>(queue: mockQueue)
        
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
        
        let bfs = BreadthFirstSearch<MockBreadthFirstSearchTraits>(queue: mockQueue)
        
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


