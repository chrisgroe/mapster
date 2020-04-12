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
        
        var pushList : [Coords] = []
        var popList : [Coords] = []
        
        func push(_ element: Coords) {
            pushList.append(element)
        }
        
        func pop() -> Coords? {
            guard popList.count != 0 else {
                return nil
            }
            return popList.removeFirst()
        }
    }
    
    class MockNavigatable : Navigatable {
        var testVector : [[Coords]] =  []
        
        func getNeighbours(coords: Coords) -> [Coords] {
            guard testVector.count != 0 else {
                return []
            }
            return testVector.removeFirst()
        }
        
        
    }
    
    func test_visit_withSingleElement() {
        
        let mockQueue = MockVisitorQueue()
        mockQueue.popList = [Coords(x:0, y:0)]
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [] // no neighbours
        
        var floodVisitor = FloodVisitor(queue: mockQueue)
        
        var visited : [Coords] = []
        func visitor(_ coords : Coords) {
            visited.append(coords)
        }
        
        floodVisitor.visit(startPos: Coords(x:0,y:0), navigation: mockNavigatable, visitor:visitor)
        
        XCTAssertEqual(visited, [Coords(x:0, y:0)])
        XCTAssertEqual(mockQueue.pushList, [Coords(x:0, y:0)])
    }
    
    func test_visit_withLoop() {
        
        let mockQueue = MockVisitorQueue()
        mockQueue.popList = [Coords(x:0, y:0)]
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [[Coords(x:0, y:0)]]
        
        var floodVisitor = FloodVisitor(queue: mockQueue)
        
        var visited : [Coords] = []
        func visitor(_ coords : Coords) {
            visited.append(coords)
        }
        
        floodVisitor.visit(startPos: Coords(x:0,y:0), navigation: mockNavigatable, visitor:visitor)
        
        XCTAssertEqual(visited, [Coords(x:0, y:0)])
        XCTAssertEqual(mockQueue.pushList, [Coords(x:0, y:0)])
    }
    
    func test_visit_with1NeighbourAndPopListIsEmpty() {
         
         let mockQueue = MockVisitorQueue()
         mockQueue.popList = [Coords(x:0, y:0)] // result of pop
         
         let mockNavigatable = MockNavigatable()
         mockNavigatable.testVector = [[Coords(x:1, y:0)]] // result of neighbor query
         
         var floodVisitor = FloodVisitor(queue: mockQueue)
         
         var visited : [Coords] = []
         func visitor(_ coords : Coords) {
             visited.append(coords)
         }
         
         floodVisitor.visit(startPos: Coords(x:0,y:0), navigation: mockNavigatable, visitor:visitor)
         
         XCTAssertEqual(visited, [Coords(x:0, y:0)]) // neighbor not on pop list
         XCTAssertEqual(mockQueue.pushList, [Coords(x:0, y:0), Coords(x:1, y:0)])
     }
    
    func test_visit_with1NeighbourAndPopReturnsCorrectNeighbour() {
        
        let mockQueue = MockVisitorQueue()
        mockQueue.popList = [Coords(x:0, y:0),Coords(x:1, y:0)] // result of pop
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [[Coords(x:1, y:0)]] // result of neighbor query
        
        var floodVisitor = FloodVisitor(queue: mockQueue)
        
        var visited : [Coords] = []
        func visitor(_ coords : Coords) {
            visited.append(coords)
        }
        
        floodVisitor.visit(startPos: Coords(x:0,y:0), navigation: mockNavigatable, visitor:visitor)
        
        XCTAssertEqual(visited, [Coords(x:0, y:0), Coords(x:1, y:0)])
        XCTAssertEqual(mockQueue.pushList, [Coords(x:0, y:0), Coords(x:1, y:0)])
    }
    
    func test_visit_with1NeighbourAndPopReturnsCorrectNeighbourAndLoop() {
        
        let mockQueue = MockVisitorQueue()
        mockQueue.popList = [Coords(x:0, y:0),Coords(x:1, y:0)] // result of pop
        
        let mockNavigatable = MockNavigatable()
        mockNavigatable.testVector = [[Coords(x:1, y:0),Coords(x:0, y:0)]] // result of neighbor query
        
        var floodVisitor = FloodVisitor(queue: mockQueue)
        
        var visited : [Coords] = []
        func visitor(_ coords : Coords) {
            visited.append(coords)
        }
        
        floodVisitor.visit(startPos: Coords(x:0,y:0), navigation: mockNavigatable, visitor:visitor)
        
        XCTAssertEqual(visited, [Coords(x:0, y:0), Coords(x:1, y:0)])
        XCTAssertEqual(mockQueue.pushList, [Coords(x:0, y:0), Coords(x:1, y:0)]) // Following element 0,0 is excluded!
    }
    
    
 
    
    
}

    
