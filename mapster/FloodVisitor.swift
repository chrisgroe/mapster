//
//  FloodVisitor.swift
//  mapster
//
//  Created by Christian Gröling on 11.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

protocol FloodVisitorQueueProtocol {
    
    associatedtype Element
    func push(_ element: Element)
    func pop() ->Element?
}

struct FloodVisitorGeneric<T> where T : FloodVisitorQueueProtocol {
    
    typealias QueueType  = T
    let queue : QueueType
    
    init (queue : QueueType)  {
        self.queue = queue

    }
    
    func visit(visitor : (T)->Bool) {
        
    }
}

extension Stack : FloodVisitorQueueProtocol  {}
typealias FloodVisitor<T> = FloodVisitorGeneric<Stack<T>>
