//
//  FloodVisitor.swift
//  mapster
//
//  Created by Christian Gröling on 11.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation


protocol Queue {
    
    associatedtype Element
    init()
    mutating func push(_ element: Element)
    mutating func pop() -> Element?
}


protocol Navigatable {
    func getNeighbours(coords : GridPos) -> [GridPos]
}


struct BreadthFirstSearch<Q : Queue> where Q.Element == GridPos{
    var queue : Q
    init (queue : Q = Q())  {
        self.queue = queue
    }
    
    mutating func search( startPos : GridPos, navigation : Navigatable,  visitor: (_ coords : GridPos) ->() )
    {
        
        var visited = Set<GridPos>() // store information which nodes were visited
 
        queue.push(startPos)
        visited.insert(startPos)
        
        while let pos = queue.pop() {
            
            // visit the node
            visitor(pos)
            
            // get connections
            let neighbours = navigation.getNeighbours(coords: pos)
            
            // enqueue connections if they are navigatable
            for neighbour in neighbours {
                if visited.contains(neighbour) == false {
                    queue.push(neighbour)
                    visited.insert(pos)
                }
                
            }
        }
        
    }
}
