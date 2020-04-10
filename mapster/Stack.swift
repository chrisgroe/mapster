//
//  Stack.swift
//  mapster
//
//  Created by Christian Gröling on 10.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

extension ForwardLinkedList : StackContainerProtocol{
}

/// A stack (Last-In First-Out) datastructure.
struct Stack<ContainerType> where ContainerType : StackContainerProtocol  {
    typealias Element = ContainerType.Element
    
    fileprivate var container : ContainerType
    
    /// Initializes an empty stack
    init( )
    {
        self.container = ContainerType()
    }
    
    /// Initializes the stack with a sequence
    ///
    /// Element order is [bottom, ..., top], as if one were to iterate through the sequence in reverse.
    init<S>(_ s: S) where Element == S.Element, S : Sequence
    {
        self.init()
        
        for i in s {
            self.container.prepend(i)
        }
    }
    
    /// Initializes the stack with variadic parameters
    ///
    /// Element order is (bottom, ..., top),  as if one were to iterate through the sequence in reverse.
    init(_ values: Element...) {

        self.init()
        
        for i in values {
            self.container.prepend(i)
        }
    }
    
    /// Pushes an element to the top of the stack
    /// - Parameters:
    ///     - element: The element to be pushed.
    func push(_ element: Element) {
        container.prepend(element)
    }

    /// Removes the top element from stack and returns it.
    ///
    /// This method reduces the size of the stack by 1.
    /// - Returns:The top element of the stack or nil when the stack is empty.
    func pop() -> Element? {
        if isEmpty {
            return nil
        }
        
        return container.removeFirst()
    }
    
    /// The top element of the stack.
    ///
    /// This is the last one pushed to the the stack or nil when the stack is empty.
    var front: Element? {
        return container.first
    }
    
    /// The number of elements currently contained in the stack
    var count: Int {
        return container.count
    }
    
    /// True when the stack is empty
    var isEmpty: Bool {
        return container.isEmpty
    }
    
}

