//
//  BreadthFirstSearch.swift
//  mapster
//
//  Created by Christian Gröling on 11.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

protocol BreadthFirstSearchTypeTraits {
    associatedtype Node : Hashable
    associatedtype NavGraph : NavigatableGraph where NavGraph.Node == Node
    associatedtype QFactory : QueueFactory where QFactory.QueueType.Element == Node
}

/// Breadth First Search (BFS) is an algorithmn for traversing or searching  a graph.
/// BFS explores the nearest nodes first.
struct BreadthFirstSearch<T : BreadthFirstSearchTypeTraits>
{
    typealias Node = T.Node
    typealias NavGraph = T.NavGraph
    typealias QFactory = T.QFactory
    
    private var queueFactory : QFactory
    
    init (queueFactory : QFactory)  {
        self.queueFactory = queueFactory
    }
    
    /// Traverses the given graph
    /// - Parameters:
    ///     - start: The node of the graph where the traversal should begin.
    ///     - navGraph: A class which implements the graph NavigatableGraph protocol.
    ///     - visitor: This function is called everytime a node is opended by the algorithmn
    func traverse( start : Node, navGraph : NavGraph,  visitor: (_ coords : Node) ->() )
    {
        var visited = Set<Node>() // store information which nodes were visited
        var queue = queueFactory.create()
        
        queue.push(start)
        visited.insert(start)
        
        while let pos = queue.pop() {
            
            // visit the node
            visitor(pos)
            
            // get connections
            let neighbours = navGraph.getEdges(of: pos)
            
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
