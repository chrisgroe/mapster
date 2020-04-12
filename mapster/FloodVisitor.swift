//
//  FloodVisitor.swift
//  mapster
//
//  Created by Christian Gröling on 11.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation


protocol FloodVisitorQueueProtocol {
    mutating func push(_ element: GridPos)
    mutating func pop() -> GridPos?
}

protocol Navigatable {
    func getNeighbours(coords : GridPos) -> [GridPos]
}


extension Stack  : FloodVisitorQueueProtocol where Element == GridPos {
}

struct FloodVisitor{
    

    var queue : FloodVisitorQueueProtocol
    
    init (queue : FloodVisitorQueueProtocol = Stack<GridPos>())  {
        self.queue = queue
    }
    
    mutating func visit( startPos : GridPos, navigation : Navigatable, visitor: (_ coords : GridPos) ->() ) {
        var visited = Set<GridPos>() // store information which nodes were visited
        
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
