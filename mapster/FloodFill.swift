//
//  FloodFill.swift
//  mapster
//
//  Created by Christian Gröling on 14.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation


struct MapVertex : Hashable, MapVertexPos{
    var x: Int {
        get {
            Int(pos.x)
        }
    }
    
    var y: Int {
        get {
            Int(pos.y)
        }
    }

    var pos : CompactPos
    var data : Character = " "
    
    init(x: Int, y:Int) {
        self.pos = CompactPos(x:x, y:y)
        
    }
}

struct MapTypes : GraphTypes {
    typealias Vertex = MapVertex
    typealias NavGraph = Map<MapVertex>
}

struct QueueForGridPosFactory : QueueFactory {
    typealias QueueType = QueueArray<MapVertex>
    
    func create() -> QueueType {
        return QueueArray()
    }
}

struct BFSTypes : BreadthFirstSearchTypes {
    typealias GT = MapTypes
    typealias QFactory = QueueForGridPosFactory
}


class FloodFill {
    static func floodfill(start:MapVertex , map: Map<MapVertex>) -> Map<MapVertex> {
        
        let bfs = BreadthFirstSearch<BFSTypes>(queueFactory: QueueForGridPosFactory())
        var newMap = map
        
        bfs.traverse(start: start, navGraph: map) { v in

        }
        
        return newMap
        
    }
}
