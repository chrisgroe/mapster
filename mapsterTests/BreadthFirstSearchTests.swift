//
//  bfsTests.swift
//  mapsterTests
//
//  Created by Christian Gröling on 11.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation
import XCTest
import datastructures

@testable import mapster

class BreadthFirstSearchTests: XCTestCase {
    
    typealias Bfs = BreadthFirstSearch<MockBreadthFirstSearchTraits>
    
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
        
        typealias Vertex = MockVertex
        typealias NeighborIterator = AnyIterator<Vertex>
        
        var testVector : [[MockVertex]] =  []
        var isBlocked: (_ vertex : MockVertex) -> Bool = {p in false}
        
        func getNeighborIterator(of: MockVertex) -> NeighborIterator{
            guard testVector.count != 0 else {
                return AnyIterator<Vertex>{
                    return nil
                }
            }
            var testSequence = testVector.removeFirst()
            return AnyIterator<Vertex>{
                if testSequence.count == 0 {
                    return nil
                }
                return testSequence.removeFirst()
            }
        }
    }
    
    struct MockClosedList : GraphClosedList {
        typealias Vertex = MockVertex
        
        var set = Set<Vertex>()
        mutating func add(_ vertex: Vertex) {
            set.insert(vertex)
        }
        
        mutating func isClosed(_ vertex: Vertex) -> Bool {
            return set.contains(vertex)
        }
    }
    
    struct MockOpenedList : GraphOpenedList {
        typealias Vertex = MockVertex
        var queue = MockQueue()
        mutating func push(_ vertex: Vertex) {
            queue.push(vertex)
        }
        
        mutating func pop() -> Vertex? {
            return queue.pop()
        }
    }
    
    struct MockGraphTypeTraits : GraphTypes {
        typealias Vertex = MockVertex
        typealias NavGraph = MockNavigatableGraph
    }
    
    struct MockBreadthFirstSearchTraits : BreadthFirstSearchTypes {
        typealias GT = MockGraphTypeTraits
        typealias ClosedList = MockClosedList
        typealias OpenedList = MockOpenedList
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
                
        var visited : [MockVertex] = []
        func visitor(_ coords : MockVertex) {
            visited.append(coords)
        }
        
        var closedList = MockClosedList()
        var openedList = MockOpenedList()
        openedList.queue = mockQueue
        
        Bfs.traverse(
            start: MockVertex(x:0,y:0),
            navGraph: mockNavGraph,
            openedList: &openedList,
            closedList: &closedList,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [MockVertex(x:0, y:0)])
        XCTAssertEqual(pushList, [MockVertex(x:0, y:0)])
    }
    
    func test_traverse_withSingleBlockedNodeWithNeighbours() {
        
        var pushList = [MockVertex]()
        let mockQueue = MockQueue(
            popArray: [MockVertex(x:0, y:0)],
            pushDelegate: { x in
                pushList.append(x)
        })
        
        
        let mockNavGraph = MockNavigatableGraph()
        mockNavGraph.isBlocked = {p in p.x==0 && p.y==0}
        mockNavGraph.testVector = [[MockVertex(x: 1, y: 1)]] // no neighbours
                
        var visited : [MockVertex] = []
        func visitor(_ coords : MockVertex) {
            visited.append(coords)
        }
        
        var closedList = MockClosedList()
        var openedList = MockOpenedList()
        openedList.queue = mockQueue
        
        Bfs.traverse(
            start: MockVertex(x:0,y:0),
            navGraph: mockNavGraph,
            openedList: &openedList,
            closedList: &closedList,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [])
        XCTAssertEqual(pushList, [])
    }
    
    
    func test_traverse_withSingleNodeWithLoopNeighbor() {
        
        var pushList = [MockVertex]()
        let mockQueue = MockQueue(
            popArray: [MockVertex(x:0, y:0)],
            pushDelegate: { x in
                pushList.append(x)
        })
        
        
        let mockNavGraph = MockNavigatableGraph()
        mockNavGraph.testVector = [[MockVertex(x:0, y:0)]]
        
        var visited : [MockVertex] = []
        func visitor(_ coords : MockVertex) {
            visited.append(coords)
        }

        var closedList = MockClosedList()
        var openedList = MockOpenedList()
        openedList.queue = mockQueue
        
        Bfs.traverse(
            start: MockVertex(x:0,y:0),
            navGraph: mockNavGraph,
            openedList: &openedList,
            closedList: &closedList,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [MockVertex(x:0, y:0)])
        XCTAssertEqual(pushList, [MockVertex(x:0, y:0)])
    }
    
    func test_traverse_with1NeighborAndPopListIsEmpty() {
        
        var pushList = [MockVertex]()
        let mockQueue = MockQueue(
            popArray: [MockVertex(x:0, y:0)],
            pushDelegate: { x in
                pushList.append(x)
        })
        
        let mockNavGraph = MockNavigatableGraph()
        mockNavGraph.testVector = [[MockVertex(x:1, y:0)]] // result of neighbor query
                
        var visited : [MockVertex] = []
        func visitor(_ coords : MockVertex) {
            visited.append(coords)
        }
        var closedList = MockClosedList()
        var openedList = MockOpenedList()
        openedList.queue = mockQueue
        
        Bfs.traverse(
            start: MockVertex(x:0,y:0),
            navGraph: mockNavGraph,
            openedList: &openedList,
            closedList: &closedList,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [MockVertex(x:0, y:0)]) // neighbor not on pop list
        XCTAssertEqual(pushList, [MockVertex(x:0, y:0), MockVertex(x:1, y:0)])
    }
    
    func test_traverse_with1NeighborAndPopReturns1Neighbour() {
        
        var pushList = [MockVertex]()
        let mockQueue = MockQueue(
            popArray: [MockVertex(x:0, y:0),MockVertex(x:1, y:0)] ,
            pushDelegate: { x in
                pushList.append(x)
        })
        
        let mockNavGraph = MockNavigatableGraph()
        mockNavGraph.testVector = [[MockVertex(x:1, y:0)]] // result of neighbor query
                
        var visited : [MockVertex] = []
        func visitor(_ coords : MockVertex) {
            visited.append(coords)
        }
        var closedList = MockClosedList()
        var openedList = MockOpenedList()
        openedList.queue = mockQueue
        
        Bfs.traverse(
            start: MockVertex(x:0,y:0),
            navGraph: mockNavGraph,
            openedList: &openedList,
            closedList: &closedList,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [MockVertex(x:0, y:0), MockVertex(x:1, y:0)])
        XCTAssertEqual(pushList, [MockVertex(x:0, y:0), MockVertex(x:1, y:0)])
    }
    
    func test_traverse_with1NeighborAndPopReturns1NeighborAndSelf() {
        
        var pushList = [MockVertex]()
        let mockQueue = MockQueue(
            popArray: [MockVertex(x:0, y:0), MockVertex(x:1, y:0)] ,
            pushDelegate: { x in
                pushList.append(x)
        })
        
        let mockNavGraph = MockNavigatableGraph()
        mockNavGraph.testVector = [[MockVertex(x:1, y:0), MockVertex(x:0, y:0)]] // result of neighbor query
        
        var visited : [MockVertex] = []
        func visitor(_ coords : MockVertex) {
            visited.append(coords)
        }
        
        var closedList = MockClosedList()
        var openedList = MockOpenedList()
        openedList.queue = mockQueue
        
        Bfs.traverse(
            start: MockVertex(x:0,y:0),
            navGraph: mockNavGraph,
            openedList: &openedList,
            closedList: &closedList,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [MockVertex(x:0, y:0), MockVertex(x:1, y:0)])
        XCTAssertEqual(pushList, [MockVertex(x:0, y:0), MockVertex(x:1, y:0)]) // Following element 0,0 is excluded!
    }
    
    
    
    
    
}


