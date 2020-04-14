//
//  FloodVisitor.swift
//  mapster
//
//  Created by Christian Gröling on 11.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

protocol BreadthFirstSearchTypeTraits {
    associatedtype Element : Hashable
    associatedtype Nav : Navigatable where Nav.Element == Element
    associatedtype QFactory : QueueFactory where QFactory.QueueType.Element == Element
}

/// Breadth First Search (BFS) is an algorithmn for traversing or searching  a graph.
struct BreadthFirstSearch<T : BreadthFirstSearchTypeTraits>
{
    typealias Element = T.Element
    typealias Nav = T.Nav
    typealias QFactory = T.QFactory
    
    private var queueFactory : QFactory
    
    init (queueFactory : QFactory)  {
        self.queueFactory = queueFactory
    }
    
    /// Traverses the given graph
    /// - Parameters:
    ///     - start: The node of the graph where the traversal should begin
    func traverse( start : Element, navigation : Nav,  visitor: (_ coords : Element) ->() )
    {
        var visited = Set<Element>() // store information which nodes were visited
        var queue = queueFactory.create()
        
        queue.push(start)
        visited.insert(start)
        
        while let pos = queue.pop() {
            
            // visit the node
            visitor(pos)
            
            // get connections
            let neighbours = navigation.getNeighbours(coords: pos)
            
            // enqueue connections if they are navigatable
            for neighbour in neighbours {
                if visited.contains(neighbour) == false {
                    queue.push(neighbour)
                    visited.insert(pos)
                }
                
            }
        }
        
    }
}
