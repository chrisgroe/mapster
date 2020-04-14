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
    associatedtype Node
    
    /// Returns all available edges of the given Node
    /// - Parameters:
    ///     - node: The node of which the edges should be returned
    /// - Returns: All edges of the Node node
    func getEdges(of node: Node) -> [Node]
}

