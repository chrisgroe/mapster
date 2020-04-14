//
//  BreadthFirstSearch.swift
//  mapster
//
//  Created by Christian Gröling on 11.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

protocol BreadthFirstSearchTypeTraits {
    associatedtype Vertex : Hashable
    associatedtype NavGraph : NavigatableGraph where NavGraph.Vertex == Vertex
    associatedtype QFactory : QueueFactory where QFactory.QueueType.Element == Vertex
}

/// Breadth First Search (BFS) is an algorithmn for traversing or searching  a graph.
/// BFS explores the nearest vertices first.
struct BreadthFirstSearch<T : BreadthFirstSearchTypeTraits>
{
    typealias Vertex = T.Vertex
    typealias NavGraph = T.NavGraph
    typealias QFactory = T.QFactory
    
    private var queueFactory : QFactory
    
    init (queueFactory : QFactory)  {
        self.queueFactory = queueFactory
    }
    
    /// Traverses the given graph
    /// - Parameters:
    ///     - start: One vertex of the graph where the traversal should begin.
    ///     - navGraph: A class which implements the graph NavigatableGraph protocol.
    ///     - visitor: This function is called everytime a vertex is opended by the algorithmn
    func traverse( start : Vertex, navGraph : NavGraph,  visitor: (_ coords : Vertex) ->() )
    {
        var visited = Set<Vertex>() // store information which nodes were visited
        var queue = queueFactory.create()
        
        queue.push(start)
        visited.insert(start)
        
        while let pos = queue.pop() {
            
            // visit the node
            visitor(pos)
            
            // get connections
            let neighbours = navGraph.getNeighbors(of: pos)
            
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
