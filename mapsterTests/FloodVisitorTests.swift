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
    class MockVisitorQueue : FloodVisitorQueueProtocol {
        
        var pushList : [GridPos] = []
        var popList : [GridPos] = []
        
        func push(_ element: GridPos) {
            pushList.append(element)
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
    
    func test_visit_withSingleElement() {
        
        let mockQueue = MockVisitorQueue()
        mockQueue.popList = [GridPos(x:0, y:0)]
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [] // no neighbours
        
        var floodVisitor = FloodVisitor(queue: mockQueue)
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        floodVisitor.visit(startPos: GridPos(x:0,y:0), navigation: mockNavigatable, visitor:visitor)
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0)])
        XCTAssertEqual(mockQueue.pushList, [GridPos(x:0, y:0)])
    }
    
    func test_visit_withLoop() {
        
        let mockQueue = MockVisitorQueue()
        mockQueue.popList = [GridPos(x:0, y:0)]
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [[GridPos(x:0, y:0)]]
        
        var floodVisitor = FloodVisitor(queue: mockQueue)
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        floodVisitor.visit(startPos: GridPos(x:0,y:0), navigation: mockNavigatable, visitor:visitor)
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0)])
        XCTAssertEqual(mockQueue.pushList, [GridPos(x:0, y:0)])
    }
    
    func test_visit_with1NeighbourAndPopListIsEmpty() {
         
         let mockQueue = MockVisitorQueue()
         mockQueue.popList = [GridPos(x:0, y:0)] // result of pop
         
         let mockNavigatable = MockNavigatable()
         mockNavigatable.testVector = [[GridPos(x:1, y:0)]] // result of neighbor query
         
         var floodVisitor = FloodVisitor(queue: mockQueue)
         
         var visited : [GridPos] = []
         func visitor(_ coords : GridPos) {
             visited.append(coords)
         }
         
         floodVisitor.visit(startPos: GridPos(x:0,y:0), navigation: mockNavigatable, visitor:visitor)
         
         XCTAssertEqual(visited, [GridPos(x:0, y:0)]) // neighbor not on pop list
         XCTAssertEqual(mockQueue.pushList, [GridPos(x:0, y:0), GridPos(x:1, y:0)])
     }
    
    func test_visit_with1NeighbourAndPopReturnsCorrectNeighbour() {
        
        let mockQueue = MockVisitorQueue()
        mockQueue.popList = [GridPos(x:0, y:0),GridPos(x:1, y:0)] // result of pop
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [[GridPos(x:1, y:0)]] // result of neighbor query
        
        var floodVisitor = FloodVisitor(queue: mockQueue)
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        floodVisitor.visit(startPos: GridPos(x:0,y:0), navigation: mockNavigatable, visitor:visitor)
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0), GridPos(x:1, y:0)])
        XCTAssertEqual(mockQueue.pushList, [GridPos(x:0, y:0), GridPos(x:1, y:0)])
    }
    
    func test_visit_with1NeighbourAndPopReturnsCorrectNeighbourAndLoop() {
        
        let mockQueue = MockVisitorQueue()
        mockQueue.popList = [GridPos(x:0, y:0),GridPos(x:1, y:0)] // result of pop
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [[GridPos(x:1, y:0),GridPos(x:0, y:0)]] // result of neighbor query
        
        var floodVisitor = FloodVisitor(queue: mockQueue)
        
        var visited : [GridPos] = []
        func visitor(_ coords : GridPos) {
            visited.append(coords)
        }
        
        floodVisitor.visit(startPos: GridPos(x:0,y:0), navigation: mockNavigatable, visitor:visitor)
        
        XCTAssertEqual(visited, [GridPos(x:0, y:0), GridPos(x:1, y:0)])
        XCTAssertEqual(mockQueue.pushList, [GridPos(x:0, y:0), GridPos(x:1, y:0)]) // Following element 0,0 is excluded!
    }
    
    
 
    
    
}

    
