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
        
        init(popList : [GridPos], pushDelegate : @escaping  (_ element: GridPos) ->()) {
            self.popList = popList
            self.pushDelegate = pushDelegate
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
    
    struct MockQueueFactory : QueueFactory {
        typealias QueueType = MockQueue
        
        let mockQueue : MockQueue
        func create() -> QueueType {
            return mockQueue
        }
    }
    
    struct MockBreadthFirstSearchTraits : BreadthFirstSearchTraits {
        typealias Element = GridPos
        typealias Nav = MockNavigatable
        typealias QFactory = MockQueueFactory
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
        
        let mockQueueFactory = MockQueueFactory(mockQueue: mockQueue)
        
        let bfs = BreadthFirstSearch<MockBreadthFirstSearchTraits>(queueFactory:mockQueueFactory)
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        bfs.search(
            start: GridPos(x:0,y:0),
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
        
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [[GridPos(x:0, y:0)]]
        
        let mockQueueFactory = MockQueueFactory(mockQueue: mockQueue)
        
        let bfs = BreadthFirstSearch<MockBreadthFirstSearchTraits>(queueFactory: mockQueueFactory)
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        bfs.search(
            start: GridPos(x:0,y:0),
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
 
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [[GridPos(x:1, y:0)]] // result of neighbor query
        
        let mockQueueFactory = MockQueueFactory(mockQueue: mockQueue)
        
        let bfs = BreadthFirstSearch<MockBreadthFirstSearchTraits>(queueFactory: mockQueueFactory)
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        bfs.search(
            start: GridPos(x:0,y:0),
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
        
        let mockQueueFactory = MockQueueFactory(mockQueue: mockQueue)
        
        let bfs = BreadthFirstSearch<MockBreadthFirstSearchTraits>(queueFactory: mockQueueFactory)
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        bfs.search(
            start: GridPos(x:0,y:0),
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
        
        let mockQueueFactory = MockQueueFactory(mockQueue: mockQueue)
        let bfs = BreadthFirstSearch<MockBreadthFirstSearchTraits>(queueFactory: mockQueueFactory)
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        bfs.search(
            start: GridPos(x:0,y:0),
            navigation: mockNavigatable,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0), GridPos(x:1, y:0)])
        XCTAssertEqual(pushList, [GridPos(x:0, y:0), GridPos(x:1, y:0)]) // Following element 0,0 is excluded!
    }
    
    
    
    
    
}


