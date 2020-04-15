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
    
    private struct MapClosedList<T> : GraphClosedList {
        typealias Vertex = MapTypes<T>.Vertex
        let xlen : Int
        var map : Array<Int>
        
        init(_ xlen: Int, _ ylen :Int) {
            self.xlen = ylen
            self.map = Array<Int>.init(repeating: 0, count: xlen*ylen)
        }
        
        mutating func add(_ vertex: Vertex) {
            map[vertex.x + vertex.y * xlen] = 1
        }
        
        func isClosed(_ vertex: Vertex) -> Bool {
            return map[vertex.x + vertex.y * xlen] == 1 ? true : false
        }
    }
    

    private struct BFSTypes<T> : BreadthFirstSearchTypes {
        typealias GT = MapTypes<T>
        typealias QFactory = QueueForMapVertexFactory<T>
        typealias ClosedList = MapClosedList<T>
    }

    public static func floodFill<T>(start:MapPos, map: Map<T>, _ factory: (_ pos : MapPos)->T) -> Map<T> {
        
        let bfs = BreadthFirstSearch<BFSTypes<T>>(queueFactory: QueueForMapVertexFactory())
        var closedList = MapClosedList<T>(map.xlen, map.ylen)
        var floodedMap = map // copy
        
        bfs.traverse(start: start, navGraph: map, closedList: &closedList, visitor: { p in
            floodedMap[p] = factory(p)
        })
        
        return floodedMap
    }
}

