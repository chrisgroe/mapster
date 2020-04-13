//
//  FloodVisitorTests.swift
//  mapsterTests
//
//  Created by Christian Gröling on 11.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation
import XCTest
@testable import mapster

class FloodVisitorTests: XCTestCase {
    
    struct MockQueue : Queue {
        
        var delegatePush : (_ element: GridPos) ->()
        
        var pushList : [GridPos] = []
        var popList : [GridPos] = []
        
        mutating func push(_ element: GridPos) {
            delegatePush(element)
        }
        
        mutating func pop() -> GridPos? {
            guard popList.count != 0 else {
                return nil
            }
            return popList.removeFirst()
        }
    }
    
    struct MockQueueFactory : QueueFactory {
        var queue: MockQueue
        func create() -> Queue {
            return queue
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
    
    func test_visit_withSingleElement() {
        
        var pushList = [GridPos]()
        var mockQueue = MockQueue(delegatePush: { x in
            pushList.append(x)
        })
        mockQueue.popList = [GridPos(x:0, y:0)]
        
        let mockQueueFactory = MockQueueFactory(queue: mockQueue)
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [] // no neighbours
        
        var floodVisitor = FloodVisitor(factory: mockQueueFactory)
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        floodVisitor.visit(
            startPos: GridPos(x:0,y:0),
            navigation: mockNavigatable,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0)])
        XCTAssertEqual(pushList, [GridPos(x:0, y:0)])
    }
    
    func test_visit_withLoop() {
        
        var pushList = [GridPos]()
        var mockQueue = MockQueue(delegatePush: { x in
            pushList.append(x)
        })
        
        mockQueue.popList = [GridPos(x:0, y:0)]
        let mockQueueFactory = MockQueueFactory(queue: mockQueue)
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [[GridPos(x:0, y:0)]]
        
        var floodVisitor = FloodVisitor(factory: mockQueueFactory)
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        floodVisitor.visit(
            startPos: GridPos(x:0,y:0),
            navigation: mockNavigatable,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0)])
        XCTAssertEqual(pushList, [GridPos(x:0, y:0)])
    }
    
    func test_visit_with1NeighbourAndPopListIsEmpty() {
        
        var pushList = [GridPos]()
        var mockQueue = MockQueue(delegatePush: { x in
            pushList.append(x)
        })
        mockQueue.popList = [GridPos(x:0, y:0)] // result of pop
        let mockQueueFactory = MockQueueFactory(queue: mockQueue)
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [[GridPos(x:1, y:0)]] // result of neighbor query
        
        var floodVisitor = FloodVisitor(factory: mockQueueFactory)
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        floodVisitor.visit(
            startPos: GridPos(x:0,y:0),
            navigation: mockNavigatable,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0)]) // neighbor not on pop list
        XCTAssertEqual(pushList, [GridPos(x:0, y:0), GridPos(x:1, y:0)])
    }
    
    func test_visit_with1NeighbourAndPopReturnsCorrectNeighbour() {
        
        var pushList = [GridPos]()
        var mockQueue = MockQueue(delegatePush: { x in
            pushList.append(x)
        })
        mockQueue.popList = [GridPos(x:0, y:0),GridPos(x:1, y:0)] // result of pop
        let mockQueueFactory = MockQueueFactory(queue: mockQueue)
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [[GridPos(x:1, y:0)]] // result of neighbor query
        
        var floodVisitor = FloodVisitor(factory: mockQueueFactory)
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        floodVisitor.visit(
            startPos: GridPos(x:0,y:0),
            navigation: mockNavigatable,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0), GridPos(x:1, y:0)])
        XCTAssertEqual(pushList, [GridPos(x:0, y:0), GridPos(x:1, y:0)])
    }
    
    func test_visit_with1NeighbourAndPopReturnsCorrectNeighbourAndLoop() {
        
        var pushList = [GridPos]()
        var mockQueue = MockQueue(delegatePush: { x in
            pushList.append(x)
        })
        mockQueue.popList = [GridPos(x:0, y:0),GridPos(x:1, y:0)] // result of pop
        let mockQueueFactory = MockQueueFactory(queue: mockQueue)
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [[GridPos(x:1, y:0),GridPos(x:0, y:0)]] // result of neighbor query
        
        var floodVisitor = FloodVisitor(factory: mockQueueFactory)
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        floodVisitor.visit(
            startPos: GridPos(x:0,y:0),
            navigation: mockNavigatable,
            visitor:visitor
        )
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0), GridPos(x:1, y:0)])
        XCTAssertEqual(pushList, [GridPos(x:0, y:0), GridPos(x:1, y:0)]) // Following element 0,0 is excluded!
    }
    
    
    
    
    
}


