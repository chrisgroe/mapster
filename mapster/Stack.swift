//
//  Queue.swift
//  mapster
//
//  Created by Christian Gröling on 10.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

/// A Stack (Last-In First-Out) datastructure
public struct Stack<T> {
    typealias Element = T
    fileprivate var linkedList : ForwardLinkedList<Element>
    
    var count: Int {
        return linkedList.count
    }
    
    var isEmpty: Bool {
        return linkedList.isEmpty
    }
    
    init()
    {
        self.linkedList = ForwardLinkedList()
    }
    
    init<S>(_ s: S) where Element == S.Element, S : Sequence
    {
        self.linkedList = ForwardLinkedList(s.reversed())
    }
    
    init(_ values: Element...) {
        self.linkedList = ForwardLinkedList(values.reversed())
    }
    
    func enqueue(_ element: Element) {
        linkedList.prepend(element)
    }
    
    func dequeue() -> T? {
        if isEmpty {
            return nil
        }
        
        return linkedList.removeFirst()
    }
    
    var front: T? {
        return linkedList.first
    }
}

