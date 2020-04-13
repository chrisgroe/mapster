//
//  FloodVisitor.swift
//  mapster
//
//  Created by Christian Gröling on 11.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation


protocol Queue {
    mutating func push(_ element: GridPos)
    mutating func pop() -> GridPos?
}

protocol QueueFactory {
    func create() -> Queue
}

protocol Navigatable {
    func getNeighbours(coords : GridPos) -> [GridPos]
}


struct FloodVisitor{
    
    
    init ()  {
    }
    
    mutating func visit( startPos : GridPos, navigation : Navigatable, factory: QueueFactory, visitor: (_ coords : GridPos) ->() )
    {
        
        var visited = Set<GridPos>() // store information which nodes were visited
        var queue = factory.create()
        
        queue.push(startPos)
        visited.insert(startPos)
        
        while let pos = queue.pop() {
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
