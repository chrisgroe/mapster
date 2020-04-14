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
    
    struct MockNode {
    }
    
    struct MockQueue : Queue {
        var popArray : [GridPos] = []
        var pushDelegate : (_ element: GridPos) ->() = {x in
            return
        }
        
        func push(_ element: GridPos) {
            pushDelegate(element)
        }
        
        mutating func pop() -> GridPos? {
            guard popArray.count != 0 else {
                return nil
            }
            return popArray.removeFirst()
        }
    }
    
    
    class MockNavigatable : NavigatableGraph {
        var testVector : [[GridPos]] =  []
        
        func getEdges(of: GridPos) -> [GridPos] {
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
    
    struct MockBreadthFirstSearchTraits : BreadthFirstSearchTypeTraits {
        typealias Node = GridPos
        typealias NavGraph = MockNavigatable
        typealias QFactory = MockQueueFactory
    }
    
    func test_traverse_withSingleNodeWithoutNeighbours() {
        
        var pushList = [GridPos]()
        let mockQueue = MockQueue(
            popArray: [GridPos(x:0, y:0)],
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
        
        bfs.traverse(
            start: GridPos(x:0,y:0),
            navGraph: mockNavigatable,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0)])
        XCTAssertEqual(pushList, [GridPos(x:0, y:0)])
    }
    
    func test_traverse_withSingleNodeWithLoopNeighbour() {
        
        var pushList = [GridPos]()
        let mockQueue = MockQueue(
            popArray: [GridPos(x:0, y:0)],
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
        
        bfs.traverse(
            start: GridPos(x:0,y:0),
            navGraph: mockNavigatable,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0)])
        XCTAssertEqual(pushList, [GridPos(x:0, y:0)])
    }
    
    func test_traverse_with1NeighbourAndPopListIsEmpty() {
        
        var pushList = [GridPos]()
        let mockQueue = MockQueue(
            popArray: [GridPos(x:0, y:0)],
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
        
        bfs.traverse(
            start: GridPos(x:0,y:0),
            navGraph: mockNavigatable,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0)]) // neighbor not on pop list
        XCTAssertEqual(pushList, [GridPos(x:0, y:0), GridPos(x:1, y:0)])
    }
    
    func test_traverse_with1NeighbourAndPopReturns1Neighbour() {
        
        var pushList = [GridPos]()
        let mockQueue = MockQueue(
            popArray: [GridPos(x:0, y:0),GridPos(x:1, y:0)] ,
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
        
        bfs.traverse(
            start: GridPos(x:0,y:0),
            navGraph: mockNavigatable,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0), GridPos(x:1, y:0)])
        XCTAssertEqual(pushList, [GridPos(x:0, y:0), GridPos(x:1, y:0)])
    }
    
    func test_traverse_with1NeighbourAndPopReturns1NeighbourAndSelf() {
        
        var pushList = [GridPos]()
        let mockQueue = MockQueue(
            popArray: [GridPos(x:0, y:0), GridPos(x:1, y:0)] ,
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
        
        bfs.traverse(
            start: GridPos(x:0,y:0),
            navGraph: mockNavigatable,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0), GridPos(x:1, y:0)])
        XCTAssertEqual(pushList, [GridPos(x:0, y:0), GridPos(x:1, y:0)]) // Following element 0,0 is excluded!
    }
    
    
    
    
    
}


