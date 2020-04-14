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
    
    /// Returns all available edges of the given Node
    /// - Parameters:
    ///     - vertex: The vertex which neighbors should be returned
    /// - Returns: All vertices neighboring the given vertex.
    func getNeighbors(of vertex: Vertex) -> [Vertex]
}

