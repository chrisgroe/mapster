//
//  BreadthFirstSearch.swift
//  mapster
//
//  Created by Christian Gröling on 11.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation
import datastructures

protocol GraphClosedList {
    associatedtype Vertex
    mutating func add(_ vertex : Vertex)
    mutating func isClosed(_ vertex : Vertex) -> Bool
}

protocol GraphOpenedList {
    associatedtype Vertex
    mutating func push(_ vertex : Vertex)
    mutating func pop() -> Vertex?
}


protocol BreadthFirstSearchTypes {
    associatedtype GT : GraphTypes where GT.Vertex : Hashable
    typealias Vertex = GT.Vertex
    typealias NavGraph = GT.NavGraph
    associatedtype ClosedList : GraphClosedList where ClosedList.Vertex == Vertex
    associatedtype OpenedList : GraphOpenedList where OpenedList.Vertex == Vertex
}


/// Breadth First Search (BFS) is an algorithmn for traversing or searching  a graph.
/// BFS explores the nearest vertices first.
struct BreadthFirstSearch<T : BreadthFirstSearchTypes>
{
    typealias Vertex = T.Vertex
    typealias NavGraph = T.NavGraph
    typealias ClosedList = T.ClosedList
    typealias OpenedList = T.OpenedList
    
    /// Traverses the given graph
    /// - Parameters:
    ///     - start: One vertex of the graph where the traversal should begin.
    ///     - navGraph: A class which implements the graph NavigatableGraph protocol.
    ///     - visitor: This function is called everytime a vertex is opended by the algorithmn
    static func traverse(
        start : Vertex,
        navGraph : NavGraph,
        openedList: inout OpenedList,
        closedList : inout ClosedList,
        visitor: (_ vertex: Vertex) ->(),
        isBlocked: (_ vertex: Vertex) -> Bool = {v in false}
    )
    {
        // no not allow traversal from blocked node
        if isBlocked(start) {
            return
        }
        openedList.push(start)
        closedList.add(start)
        
        while let pos = openedList.pop() {
            
            // visit the node
            visitor(pos)
            
            // get connections
            var neighbors = navGraph.getNeighborIterator(of: pos)
        
            // enqueue connections if they are navigatable and not blocked
            while let neighbour = neighbors.next() {
                if closedList.isClosed(neighbour) == false && isBlocked(neighbour) == false {
                    openedList.push(neighbour)
                    closedList.add(pos)

                }
                
            }
        }
        
    }
}
