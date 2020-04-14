//
//  FloodFill.swift
//  mapster
//
//  Created by Christian Gröling on 14.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation


struct MapVertex : Hashable{
    var data : Character = " "
    
}

struct MapTypes : GraphTypes {
    typealias Vertex = Map<MapVertex>.Vertex
    typealias NavGraph = Map<MapVertex>
}

struct QueueForGridPosFactory : QueueFactory {
    typealias QueueType = QueueArray<Map<MapVertex>.Vertex>
    
    func create() -> QueueType {
        return QueueArray()
    }
}

struct BFSTypes : BreadthFirstSearchTypes {
    typealias GT = MapTypes
    typealias QFactory = QueueForGridPosFactory
}


class FloodFill {
    static func floodfill(start:MapId , map: Map<MapVertex>) -> Map<MapVertex> {
        
        let bfs = BreadthFirstSearch<BFSTypes>(queueFactory: QueueForGridPosFactory())
        var newMap = map
        
        bfs.traverse(start: start, navGraph: map) { v in

        }
        
        return newMap
        
    }
}
