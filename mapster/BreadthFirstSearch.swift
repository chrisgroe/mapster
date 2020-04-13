//
//  FloodVisitor.swift
//  mapster
//
//  Created by Christian Gröling on 11.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation

protocol BreadthFirstSearchTraits {
    associatedtype Element : Hashable
    associatedtype Nav : Navigatable where Nav.Element == Element
    associatedtype Q : Queue where Q.Element == Element
}

struct BreadthFirstSearch<T : BreadthFirstSearchTraits>
{
    typealias Element = T.Element
    typealias Nav = T.Nav
    typealias Q = T.Q
    
    var queue : Q
    init (queue : Q = Q())  {
        self.queue = queue
    }
    
    func search( start : Element, navigation : Nav,  visitor: (_ coords : Element) ->() )
    {
        
        var visited = Set<Element>() // store information which nodes were visited
 
        queue.push(start)
        visited.insert(start)
        
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
