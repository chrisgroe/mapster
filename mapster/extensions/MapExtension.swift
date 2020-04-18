//
//  Map.swift
//  mapster
//
//  Created by Christian Gröling on 14.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation


extension Map {
    
    func bfsTraverse(
        start: MapPos,
        visitor: (_ pos : MapPos)->(),
        isBlocked: (_ pos: MapPos) -> Bool = {p in false}
    ) {
        return MapBreadthFirstTraversal.traverse(start: start, map: self, visitor: visitor, isBlocked: isBlocked)
    }
}

