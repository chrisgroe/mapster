//
//  FloodFill.swift
//  mapster
//
//  Created by Christian Gröling on 14.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation




public class FloodFill {
    private struct QueueForMapVertexFactory : QueueFactory {
        typealias QueueType = QueueArray<Map<MapTile>.Vertex>
        
        func create() -> QueueType {
            return QueueArray()
        }
    }

    private struct BFSTypes : BreadthFirstSearchTypes {
        typealias GT = MapTypes
        typealias QFactory = QueueForMapVertexFactory
    }

    
    public static func floodFill(start:MapPos , map: Map<MapTile>) -> Map<MapTile> {
        
        let bfs = BreadthFirstSearch<BFSTypes>(queueFactory: QueueForMapVertexFactory())
        var newMap = map // copy
        
        bfs.traverse(start: start, navGraph: map) { v in
            newMap[v] = MapTile(data: "X")
        }
        
        return newMap
        
    }
}
