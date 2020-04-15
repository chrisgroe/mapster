//
//  BreadthFirstSearch.swift
//  mapster
//
//  Created by Christian Gröling on 11.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

protocol GraphClosedList {
    associatedtype Vertex
    mutating func add(_ vertex : Vertex)
    mutating func isClosed(_ vertex : Vertex) -> Bool
}

protocol BreadthFirstSearchTypes {
    associatedtype GT : GraphTypes where GT.Vertex : Hashable
    typealias Vertex = GT.Vertex
    typealias NavGraph = GT.NavGraph
    associatedtype ClosedList : GraphClosedList where ClosedList.Vertex == Vertex
    associatedtype QFactory : QueueFactory where QFactory.QueueType.Element == Vertex
}


/// Breadth First Search (BFS) is an algorithmn for traversing or searching  a graph.
/// BFS explores the nearest vertices first.
struct BreadthFirstSearch<T : BreadthFirstSearchTypes>
{
    typealias Vertex = T.Vertex
    typealias NavGraph = T.NavGraph
    typealias QFactory = T.QFactory
    typealias ClosedList = T.ClosedList

    private var queueFactory : QFactory
    
    init (queueFactory : QFactory)  {
        self.queueFactory = queueFactory
    }
    
    /// Traverses the given graph
    /// - Parameters:
    ///     - start: One vertex of the graph where the traversal should begin.
    ///     - navGraph: A class which implements the graph NavigatableGraph protocol.
    ///     - visitor: This function is called everytime a vertex is opended by the algorithmn
    func traverse( start : Vertex, navGraph : NavGraph,  closedList : inout ClosedList, visitor: (_ coords : Vertex) ->() )
    {
        var queue = queueFactory.create()
        
        queue.push(start)
        closedList.add(start)
        
        while let pos = queue.pop() {
            
            // visit the node
            visitor(pos)
            
            // get connections
            var neighbors = navGraph.getNeighbors(of: pos)
            
            // enqueue connections if they are navigatable
            while let neighbour = neighbors.next() {
                if closedList.isClosed(neighbour) == false {
                    queue.push(neighbour)
                    closedList.add(pos)

                }
                
            }
        }
        
    }
}
