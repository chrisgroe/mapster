//
//  FloodFill.swift
//  mapster
//
//  Created by Christian Gröling on 14.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation
import datastructures

import datastructures

public class MapBreadthFirstTraversal
{
    private init(){
    }

    /// A datastructure to hold closed vertices
    /// - Note: A map is a 2d array, in this case an array can be used as closed list. This is a bit faster than using
    ///         a Set.
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
    
    private struct MapOpenedList<T> : GraphOpenedList {
        typealias Vertex = MapTypes<T>.Vertex
        
        var queue = QueueArray<Vertex>()
        mutating func push(_ vertex: Vertex) {
            queue.push(vertex)
        }
        
        mutating func pop() -> Vertex? {
            return queue.pop()
        }
    }

    private struct BFSTypes<T> : BreadthFirstSearchTypes {
        typealias GT = MapTypes<T>
        typealias ClosedList = MapClosedList<T>
        typealias OpenedList = MapOpenedList<T>
        
    }

    public static func traverse<T>(
        start:MapPos,
        map: Map<T>,
        visitor: (_ pos : MapPos)->(),
        isBlocked: (_ pos : MapPos)->Bool = {p in false}
    ) {
        
        typealias bfs = BreadthFirstSearch<BFSTypes<T>>
        var closedList = MapClosedList<T>(map.xlen, map.ylen)
        var openedList = MapOpenedList<T>()
 
        bfs.traverse(start: start,
                     navGraph: map,
                     openedList: &openedList,
                     closedList: &closedList,
                     visitor: visitor,
                     isBlocked: isBlocked
        )
    }
}

