//
//  FloodFill.swift
//  mapster
//
//  Created by Christian Gröling on 14.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation




public class FloodFill {
    private struct QueueForMapVertexFactory<T> : QueueFactory {
        typealias QueueType = QueueArray<Map<T>.Vertex>
        
        func create() -> QueueType {
            return QueueArray()
        }
    }

    private struct BFSTypes<T> : BreadthFirstSearchTypes {
        typealias GT = MapTypes<T>
        typealias QFactory = QueueForMapVertexFactory<T>
    }

    
    public static func floodFill<T>(start:MapPos, map: Map<T>, factory: (_ pos : MapPos)->T) -> Map<T> {
        
        let bfs = BreadthFirstSearch<BFSTypes<T>>(queueFactory: QueueForMapVertexFactory())
        var newMap = map // copy
        
        bfs.traverse(start: start, navGraph: map, visitor: { p in
            newMap[p] = factory(p)
        })
        
        return newMap
    }
}


extension Map where Data == MapTile{
    
    func floodFill(_ pos:MapPos, factory: (_ pos : MapPos)->MapTile) -> Map<MapTile> {
        return FloodFill.floodFill(start: pos, map: self, factory: factory)
    }
}
