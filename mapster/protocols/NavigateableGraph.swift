//
//  NavigateableGraph.swift
//  mapster
//
//  Created by Christian Gröling on 13.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation


/// Each graph which is navigatable must conform this protocol
protocol NavigatableGraph {
    associatedtype Vertex
    associatedtype NeighborIterator : IteratorProtocol where NeighborIterator.Element == Vertex
    
    /// Returns all neighbors of the given vertex
    /// - Parameters:
    ///     - vertex: The vertex of which all neighbors should be returned
    /// - Returns: All vertices neighboring the given vertex.
    func getNeighborIterator(of vertex: Vertex) -> NeighborIterator
    
    /// Returns the predicate which is used to check if a vertex is blocked
    var isBlocked : (_ vertex: Vertex) -> Bool {
        get
    }
}

