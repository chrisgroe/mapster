//
//  FloodVisitor.swift
//  mapster
//
//  Created by Christian Gröling on 11.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation


protocol FloodVisitorQueueProtocol {
    mutating func push(_ element: Coords)
    mutating func pop() -> Coords?
}

protocol Navigatable {
    func getNeighbours(coords : Coords) -> [Coords]
}


extension Stack  : FloodVisitorQueueProtocol where Element == Coords {
}

struct FloodVisitor{
    

    var queue : FloodVisitorQueueProtocol
    
    init (queue : FloodVisitorQueueProtocol = Stack<Coords>())  {
        self.queue = queue
    }
    
    mutating func visit( startPos : Coords, navigation : Navigatable, visitor: (_ coords : Coords) ->() ) {
        var visited = Set<Coords>()
        
        queue.push(startPos)
        
        while let pos = queue.pop() {
            visitor(pos)
            visited.insert(pos)

            // get connections
            let neighbours = navigation.getNeighbours(coords: pos)
            
            // enqueue connections if they are navigatable
            for neighbour in neighbours {
                if visited.contains(neighbour) == false {
                    queue.push(neighbour)
                }
                
            }
        }
        
    }
}
