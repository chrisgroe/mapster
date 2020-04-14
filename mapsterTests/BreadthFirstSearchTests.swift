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
    
    struct MockVertex : Hashable{
        var x : Int
        var y : Int
    }
    
    struct MockQueue : Queue {
        var popArray : [MockVertex] = []
        var pushDelegate : (_ element: MockVertex) ->() = {x in
            return
        }
        
        func push(_ element: MockVertex) {
            pushDelegate(element)
        }
        
        mutating func pop() -> MockVertex? {
            guard popArray.count != 0 else {
                return nil
            }
            return popArray.removeFirst()
        }
    }
    
    
    class MockNavigatableGraph : NavigatableGraph {
        var testVector : [[MockVertex]] =  []
        
        func getNeighbors(of: MockVertex) -> [MockVertex] {
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
    
    struct MockGraphTypeTraits : GraphTypeTraits {
        typealias Vertex = MockVertex
        typealias NavGraph = MockNavigatableGraph
    }
    
    struct MockBreadthFirstSearchTraits : BreadthFirstSearchTypeTraits {
        typealias GraphTypes = MockGraphTypeTraits
        typealias QFactory = MockQueueFactory
    }
    
    func test_traverse_withSingleNodeWithoutNeighbours() {
        
        var pushList = [MockVertex]()
        let mockQueue = MockQueue(
            popArray: [MockVertex(x:0, y:0)],
            pushDelegate: { x in
                pushList.append(x)
        })
        
        
        let mockNavGraph = MockNavigatableGraph()
        mockNavGraph.testVector = [] // no neighbours
        
        let mockQueueFactory = MockQueueFactory(mockQueue: mockQueue)
        
        let bfs = BreadthFirstSearch<MockBreadthFirstSearchTraits>(queueFactory:mockQueueFactory)
        
        var visited : [MockVertex] = []
        func visitor(_ coords : MockVertex) {
            visited.append(coords)
        }
        
        bfs.traverse(
            start: MockVertex(x:0,y:0),
            navGraph: mockNavGraph,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [MockVertex(x:0, y:0)])
        XCTAssertEqual(pushList, [MockVertex(x:0, y:0)])
    }
    
    func test_traverse_withSingleNodeWithLoopNeighbour() {
        
        var pushList = [MockVertex]()
        let mockQueue = MockQueue(
            popArray: [MockVertex(x:0, y:0)],
            pushDelegate: { x in
                pushList.append(x)
        })
        
        
        let mockNavGraph = MockNavigatableGraph()
        mockNavGraph.testVector = [[MockVertex(x:0, y:0)]]
        
        let mockQueueFactory = MockQueueFactory(mockQueue: mockQueue)
        
        let bfs = BreadthFirstSearch<MockBreadthFirstSearchTraits>(queueFactory: mockQueueFactory)
        
        var visited : [MockVertex] = []
        func visitor(_ coords : MockVertex) {
            visited.append(coords)
        }
        
        bfs.traverse(
            start: MockVertex(x:0,y:0),
            navGraph: mockNavGraph,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [MockVertex(x:0, y:0)])
        XCTAssertEqual(pushList, [MockVertex(x:0, y:0)])
    }
    
    func test_traverse_with1NeighbourAndPopListIsEmpty() {
        
        var pushList = [MockVertex]()
        let mockQueue = MockQueue(
            popArray: [MockVertex(x:0, y:0)],
            pushDelegate: { x in
                pushList.append(x)
        })
 
        let mockNavGraph = MockNavigatableGraph()
        mockNavGraph.testVector = [[MockVertex(x:1, y:0)]] // result of neighbor query
        
        let mockQueueFactory = MockQueueFactory(mockQueue: mockQueue)
        
        let bfs = BreadthFirstSearch<MockBreadthFirstSearchTraits>(queueFactory: mockQueueFactory)
        
        var visited : [MockVertex] = []
        func visitor(_ coords : MockVertex) {
            visited.append(coords)
        }
        
        bfs.traverse(
            start: MockVertex(x:0,y:0),
            navGraph: mockNavGraph,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [MockVertex(x:0, y:0)]) // neighbor not on pop list
        XCTAssertEqual(pushList, [MockVertex(x:0, y:0), MockVertex(x:1, y:0)])
    }
    
    func test_traverse_with1NeighbourAndPopReturns1Neighbour() {
        
        var pushList = [MockVertex]()
        let mockQueue = MockQueue(
            popArray: [MockVertex(x:0, y:0),MockVertex(x:1, y:0)] ,
            pushDelegate: { x in
                pushList.append(x)
        })
        
        let mockNavGraph = MockNavigatableGraph()
        mockNavGraph.testVector = [[MockVertex(x:1, y:0)]] // result of neighbor query
        
        let mockQueueFactory = MockQueueFactory(mockQueue: mockQueue)
        
        let bfs = BreadthFirstSearch<MockBreadthFirstSearchTraits>(queueFactory: mockQueueFactory)
        
        var visited : [MockVertex] = []
        func visitor(_ coords : MockVertex) {
            visited.append(coords)
        }
        
        bfs.traverse(
            start: MockVertex(x:0,y:0),
            navGraph: mockNavGraph,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [MockVertex(x:0, y:0), MockVertex(x:1, y:0)])
        XCTAssertEqual(pushList, [MockVertex(x:0, y:0), MockVertex(x:1, y:0)])
    }
    
    func test_traverse_with1NeighbourAndPopReturns1NeighbourAndSelf() {
        
        var pushList = [MockVertex]()
        let mockQueue = MockQueue(
            popArray: [MockVertex(x:0, y:0), MockVertex(x:1, y:0)] ,
            pushDelegate: { x in
                pushList.append(x)
        })
        
        let mockNavGraph = MockNavigatableGraph()
        mockNavGraph.testVector = [[MockVertex(x:1, y:0), MockVertex(x:0, y:0)]] // result of neighbor query
        
        let mockQueueFactory = MockQueueFactory(mockQueue: mockQueue)
        let bfs = BreadthFirstSearch<MockBreadthFirstSearchTraits>(queueFactory: mockQueueFactory)
        
        var visited : [MockVertex] = []
        func visitor(_ coords : MockVertex) {
            visited.append(coords)
        }
        
        bfs.traverse(
            start: MockVertex(x:0,y:0),
            navGraph: mockNavGraph,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [MockVertex(x:0, y:0), MockVertex(x:1, y:0)])
        XCTAssertEqual(pushList, [MockVertex(x:0, y:0), MockVertex(x:1, y:0)]) // Following element 0,0 is excluded!
    }
    
    
    
    
    
}


