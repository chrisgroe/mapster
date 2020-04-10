//
//  LinkedListTests.swift
//  LinkedListTests
//
//  Created by Christian Gröling on 27.03.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import XCTest
@testable import mapster

class ForwardLinkedListTests: XCTestCase {

    
    func testInitBySequence() {
        let ll = ForwardLinkedList<Int>([1,2,3,4])
        
        XCTAssertEqual(ll.count,4)
        XCTAssertEqual(Array<Int>(ll), [1,2,3,4])
    }
    
    func testInitByRange() {
        let ll = ForwardLinkedList<Int>(1...4)
        
        XCTAssertEqual(ll.count,4)
        XCTAssertEqual(Array<Int>(ll), [1,2,3,4])
    }
    
    func testInitRepeating() {
           let ll = ForwardLinkedList<Int>(repeating: 123, count: 4)
           
           XCTAssertEqual(ll.count,4)
           XCTAssertEqual(Array<Int>(ll), [123,123,123,123])
       }

    func testFirst0Elements() {
        let ll = ForwardLinkedList<String>()

        XCTAssertNil(ll.first)
    }
    
    func testLast0Elements() {
        let ll = ForwardLinkedList<String>()
        
        XCTAssertNil(ll.last)
    }
    
    func testFirst1Elements() {
        let ll = ForwardLinkedList<Int>()
        ll.append(123)
        XCTAssertEqual(ll.first,123)
    }
    
    func testLast1Elements() {
        let ll = ForwardLinkedList<Int>()
        ll.append(123)
        XCTAssertEqual(ll.last,123)
    }
    
    func testFirst2Elements() {
        let ll = ForwardLinkedList<Int>()
        ll.append(123)
        ll.append(321)
        XCTAssertEqual(ll.first,123)
    }
    
    func testLast2Elements() {
        let ll = ForwardLinkedList<Int>()
        ll.append(123)
        ll.append(321)
        XCTAssertEqual(ll.last,321)
    }
    
    
    func testIterator0Elements() {
        let ll = ForwardLinkedList<String>()
        let it = ll.makeIterator()
        
        let value0 = it.next()
        XCTAssertNil(value0)
        
        let value1 = it.next()
        XCTAssertNil(value1)
    }

    func testIterator1Elements() {
        let ll = ForwardLinkedList<String>()
        ll.append("1 - Test String - 1")
        let it = ll.makeIterator()
        
        let value0 = it.next()
        XCTAssertEqual(value0, "1 - Test String - 1")
        
        let value1 = it.next()
        XCTAssertNil(value1)
    }
    
    func testIterator2Elements() {
        let ll = ForwardLinkedList<String>()
        ll.append("1 - Test String - 1")
        ll.append("2 - Test String - 2")
        let it = ll.makeIterator()
        
        let value0 = it.next()
        XCTAssertEqual(value0,"1 - Test String - 1")
        
        let value1 = it.next()
        XCTAssertEqual(value1, "2 - Test String - 2")
        
        let value2 = it.next()
        XCTAssertNil(value2)
    }
    
    
    func testGetNodeByIndexOutOfBonds() {
        let ll = ForwardLinkedList<Int>()
        ll.append(2) //0
        ll.append(3)
        ll.append(1) //2
        XCTAssertNil(ll.gotoNode(at: 3))
    }
    
    func testGetNodeByIndexEmpty() {
        let ll = ForwardLinkedList<Int>()
        XCTAssertNil(ll.gotoNode(at: 0))
        XCTAssertNil(ll.gotoNode(at: 1))
    }
    
    func testCount0Elements() {
        let ll = ForwardLinkedList<Int>()
        XCTAssertEqual(ll.count, 0)
    }
    
    func testCount3Elements() {
        let ll = ForwardLinkedList<Int>()
        ll.append(2)
        ll.append(3)
        ll.append(1)
        XCTAssertEqual(ll.count, 3)
    }
    
    func testFirstIndexOf() {
        let ll = ForwardLinkedList<Int>()
        ll.append(2)
        ll.append(3)
        ll.append(-3)
        ll.append(1)
        
        XCTAssertEqual(ll.firstIndex(of: -3), 2)
    }
    
    func testDistance() {
        let ll = ForwardLinkedList<Int>()
        ll.append(2)
        ll.append(3)
        ll.append(-3)
        ll.append(1)
        
        XCTAssertEqual(ll.distance(from: 0, to: 2), 2)
    }
    
    func testSubscriptMutating() {
        let ll = ForwardLinkedList<Int>()
        ll.append(2)
        ll.append(3)
        ll.append(-3)
        ll.append(1)
        XCTAssertEqual(ll[2], -3)
        ll[2] = 4
        XCTAssertEqual(ll[2], 4)
    }
    
    func testSorted() {
        let ll = ForwardLinkedList<Int>()
        ll.append(2)
        ll.append(3)
        ll.append(1)
        ll.append(-2)
        ll.append(-10)
        
        let sortedArray = ll.sorted()
        XCTAssertEqual(sortedArray[0], -10)
        XCTAssertEqual(sortedArray[1], -2)
        XCTAssertEqual(sortedArray[2], 1)
        XCTAssertEqual(sortedArray[3], 2)
        XCTAssertEqual(sortedArray[4], 3)
        
    }
    
    func testInsertEmpty() {
        let ll = ForwardLinkedList<Int>()
        ll.insert(10, at: 0)
        XCTAssertEqual(ll.count, 1)
        XCTAssertEqual(ll[0], 10)
    }
    
    func testInsertAtStart() {
        let ll = ForwardLinkedList<Int>()
        ll.append(11)
        ll.insert(10, at: 0)
        XCTAssertEqual(ll.count, 2)
        XCTAssertEqual(ll[0], 10)
        XCTAssertEqual(ll[1], 11)
    }
    
    func testInsertAtMid() {
        let ll = ForwardLinkedList<Int>()
        ll.append(11) // 0
        ll.append(12) // 1
        ll.append(13) // 2
        ll.insert(10, at: 1)
        XCTAssertEqual(ll.count, 4)
        XCTAssertEqual(ll[0], 11)
        XCTAssertEqual(ll[1], 10)
        XCTAssertEqual(ll[2], 12)
        XCTAssertEqual(ll[3], 13)
    }
    
    func testInsertAtEnd() {
        let ll = ForwardLinkedList<Int>()
        ll.append(11)
        ll.insert(10, at: 1)
        XCTAssertEqual(ll.count, 2)
        XCTAssertEqual(ll[0], 11)
        XCTAssertEqual(ll[1], 10)
    }
    
    func testRemoveStart() {
        let ll = ForwardLinkedList<Int>()
        ll.append(2)
        ll.append(3)
        ll.append(1)
        ll.append(-2)
        ll.append(-10)
        
        let removedElement = ll.remove(at:0)
        XCTAssertEqual(removedElement, 2)
        XCTAssertEqual(ll[0], 3)
        XCTAssertEqual(ll[1], 1)
        XCTAssertEqual(ll[2], -2)
        XCTAssertEqual(ll[3], -10)
        
    }
    
    func testRemoveMid() {
        let ll = ForwardLinkedList<Int>()
        ll.append(2)
        ll.append(3)
        ll.append(1)
        ll.append(-2)
        ll.append(-10)
        
        let removedElement = ll.remove(at:2)
        XCTAssertEqual(removedElement, 1)
        XCTAssertEqual(ll[0], 2)
        XCTAssertEqual(ll[1], 3)
        XCTAssertEqual(ll[2], -2)
        XCTAssertEqual(ll[3], -10)
        
    }
    
    func testRemoveEnd() {
        let ll = ForwardLinkedList<Int>()
        ll.append(2)
        ll.append(3)
        ll.append(1)
        ll.append(-2)
        ll.append(-10)

        let removedElement = ll.remove(at:ll.endIndex-1)
        XCTAssertEqual(removedElement, -10)
        XCTAssertEqual(ll[0], 2)
        XCTAssertEqual(ll[1], 3)
        XCTAssertEqual(ll[2], 1)
        XCTAssertEqual(ll[3], -2)
    }
    
    func testConcat2LinkedLists() {
        let ll1 = ForwardLinkedList<Int>(1...5)
        let ll2 = ForwardLinkedList<Int>(6...10)
        
        let ll = ll1 + ll2
        
        XCTAssertEqual(ll.count,10)
        XCTAssertEqual(Array<Int>(ll), Array<Int>(1...10))
    }
    
    func testConcatSequenceAndLinkedList() {
        let ll1 = 1...5
        let ll2 = ForwardLinkedList<Int>(6...10)
        
        let ll = ll1 + ll2
        
        XCTAssertEqual(ll.count,10)
        XCTAssertEqual(Array<Int>(ll), Array<Int>(1...10))
    }
       
    func testConcatLinkedListAndSequence() {
        let ll1 = ForwardLinkedList<Int>(1...5)
        let ll2 = 6...10
        
        let ll = ll1 + ll2
        
        XCTAssertEqual(ll.count,10)
        XCTAssertEqual(Array<Int>(ll), Array<Int>(1...10))
    }

    
    func testPrepend3Elements() {
         let ll = ForwardLinkedList<Int>()
         ll.prepend(10)
         ll.prepend(20)
         ll.prepend(30)

         XCTAssertEqual(Array<Int>(ll), [30,20,10])
     }

    // MARK: Tests CustomStringConvertible
    
    func testCustomStringConvertible0Elements() {
        let ll = ForwardLinkedList<Int>()
        XCTAssertEqual(ll.description, "[]")
    }
    
    func testCustomStringConvertible1Elements() {
        let ll = ForwardLinkedList<Int>([0])
        XCTAssertEqual(ll.description, "[0]")
    }
    func testCustomStringConvertible2Elements() {
        let ll = ForwardLinkedList<Int>([0,1])
        XCTAssertEqual(ll.description, "[0, 1]")
    }
    
    // MARK: Tests RemoveFirst
    func testRemoveFirst3Elements() {
        let ll = ForwardLinkedList<Int>([1,2,3])

        XCTAssertEqual(ll.removeFirst(), 1)
        XCTAssertEqual(ll.removeFirst(), 2)
        XCTAssertEqual(ll.removeFirst(), 3)
        XCTAssertEqual(ll.count, 0)
        XCTAssertEqual(Array<Int>(ll), [])
    }
    
    func testRemoveFirstSec3of3() {
        let ll = ForwardLinkedList<Int>([1,2,3])
        ll.removeFirst(3)
        XCTAssertEqual(ll.count, 0)
        XCTAssertEqual(Array<Int>(ll), [])

    }
    
    // MARK: Tests RemoveLast
    
    func testRemoveLast3Of3() {
        let ll = ForwardLinkedList<Int>([1,2,3])

        XCTAssertEqual(ll.removeLast(), 3)
        XCTAssertEqual(ll.removeLast(), 2)
        XCTAssertEqual(ll.removeLast(), 1)
        XCTAssertEqual(ll.count, 0)
        XCTAssertEqual(Array<Int>(ll), [])
    }
    
    func testRemoveLastSec3Of3() {
        let ll = ForwardLinkedList<Int>([1,2,3])

        ll.removeLast(3)
        XCTAssertEqual(ll.count, 0)
        XCTAssertEqual(Array<Int>(ll), [])
    }
    
    // MARK: Tests RemoveSubrange

    func testRemoveSubrangeFromRight1Of3() {
        var ll = ForwardLinkedList<Int>([1,2,3])

        ll.removeSubrange(2...2)
        XCTAssertEqual(ll.count, 2)
        XCTAssertEqual(Array<Int>(ll), [1,2])
    }
    
    func testRemoveSubrangeFromRight2Of3() {
        var ll = ForwardLinkedList<Int>([1,2,3])

        ll.removeSubrange(1...2)
        XCTAssertEqual(ll.count, 1)
        XCTAssertEqual(Array<Int>(ll), [1])
    }
    
    func testRemoveSubrangeFromRight3Of3() {
        var ll = ForwardLinkedList<Int>([1,2,3])

        ll.removeSubrange(0...2)
        XCTAssertEqual(ll.count, 0)
        XCTAssertEqual(Array<Int>(ll), [])
    }
    func testRemoveSubrangeFromLeft2Of3() {
        var ll = ForwardLinkedList<Int>([1,2,3])

        ll.removeSubrange(0...1)
        XCTAssertEqual(ll.count, 1)
        XCTAssertEqual(Array<Int>(ll), [3])
    }
    
    func testRemoveSubrangeFromLeft1Of3() {
        var ll = ForwardLinkedList<Int>([1,2,3])

        ll.removeSubrange(0...0)
        XCTAssertEqual(ll.count, 2)
        XCTAssertEqual(Array<Int>(ll), [2,3])
    }
    
    func testRemoveSubrangeMid1Of3() {
        var ll = ForwardLinkedList<Int>([1,2,3])

        ll.removeSubrange(1...1)
        XCTAssertEqual(ll.count, 2)
        XCTAssertEqual(Array<Int>(ll), [1,3])
    }
    
    func testRemoveSubrangeMid2Of4() {
        var ll = ForwardLinkedList<Int>([1,2,3,4])

        ll.removeSubrange(1...2)
        XCTAssertEqual(ll.count, 2)
        XCTAssertEqual(Array<Int>(ll), [1,4])
    }
    
    func testRemoveSubrange1of1() {
        var ll = ForwardLinkedList<Int>([1])

        ll.removeSubrange(0...0)
        XCTAssertEqual(ll.count, 0)
        XCTAssertEqual(Array<Int>(ll), [])
    }
    
    func testRemoveSubrange2of2() {
        var ll = ForwardLinkedList<Int>([1, 2])

        ll.removeSubrange(0...1)
        XCTAssertEqual(ll.count, 0)
        XCTAssertEqual(Array<Int>(ll), [])
    }
    
    
    func testRemoveLastSec2Of3() {
        let ll = ForwardLinkedList<Int>([1,2,3])

        ll.removeLast(2)
        XCTAssertEqual(ll.count, 1)
        XCTAssertEqual(Array<Int>(ll), [1])
    }

    // MARK: Reverse
    
    func testReverseLinkedListEmpty() {
        let ll = ForwardLinkedList<Int>()
        
        ll.reverse()
        
        XCTAssertEqual(ll.count, 0)
        XCTAssertEqual(Array<Int>(ll), [])
    }
    
    func testReverseLinkedList1Element() {
        let ll = ForwardLinkedList<Int>(123)
        
        ll.reverse()
        
        XCTAssertEqual(ll.count, 1)
        XCTAssertEqual(Array<Int>(ll), [123])
    }

    func testReverseLinkedList2Elements() {
        let ll = ForwardLinkedList<Int>(123,321)
        
        ll.reverse()
        
        XCTAssertEqual(ll.count, 2)
        XCTAssertEqual(Array<Int>(ll), [321, 123])
    }
    
    func testReverseLinkedList3Element() {
          let ll = ForwardLinkedList<Int>(0,1,2)
          
          ll.reverse()
          
          XCTAssertEqual(ll.count, 3)
          XCTAssertEqual(Array<Int>(ll), [2,1,0])
      }
      
    
    
    func testReverseLinkedList() {
        let ll = ForwardLinkedList(1, 1, 2, 3, 5, 8)
        
        ll.reverse()
        
        XCTAssertEqual(ll.count, 6)
        XCTAssertEqual(Array<Int>(ll), [8, 5, 3, 2, 1, 1])
    }
    
    // MARK: Equatable
    func testEqual5Elements() {
        var ll1 = ForwardLinkedList<Int>(1,2,3,4,5,6)
        var ll2 = ForwardLinkedList<Int>(1,2,3,4,5,6)
        XCTAssertTrue(ll1 == ll2)
        
        ll2 = ForwardLinkedList<Int>(1,2,3,4,6,5)
        XCTAssertFalse(ll1 == ll2)
        
        ll1 = ForwardLinkedList<Int>(2,1,3,4,5,6)
        ll2 = ForwardLinkedList<Int>(1,2,3,4,5,6)
        XCTAssertFalse(ll1 == ll2)
    }
    func testEqual_differentLength_returnFalse() {
        let ll1 = ForwardLinkedList<Int>(1,2,3,4,5,6)
        let ll2 = ForwardLinkedList<Int>(1,2,3,4,5)
        XCTAssertFalse(ll1 == ll2)
    }
    
    func testNotEqual5Elements() {
        var ll1 = ForwardLinkedList<Int>(1,2,3,4,5,6)
        var ll2 = ForwardLinkedList<Int>(1,2,3,4,5,6)
        XCTAssertFalse(ll1 != ll2)
        
        ll2 = ForwardLinkedList<Int>(1,2,3,4,6,5)
        XCTAssertTrue(ll1 != ll2)
        
        ll1 = ForwardLinkedList<Int>(2,1,3,4,5,6)
        ll2 = ForwardLinkedList<Int>(1,2,3,4,5,6)
        XCTAssertTrue(ll1 != ll2)
    }
    
    // MARK: Performance
    func testAppendPerformance100Elements() {
        let ll = ForwardLinkedList<Int>()
        measure {
            for _ in 0..<100 {
                ll.append(2)
            }
        }
    }
    
    func testPrependPerformance1000Elements() {
        let ll = ForwardLinkedList<Int>()
        measure {
            for _ in 0..<1000 {
                ll.prepend(2)
            }
        }
    }
    

       
}
