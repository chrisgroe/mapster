//
//  Map.swift
//  mapster
//
//  Created by Christian Gröling on 14.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation


extension Map where Element == MapTile{
    
    func bfsTraverse(
        start: MapPos,
        visitor: (_ pos : MapPos)->MapTile,
        isBlocked: (_ pos: MapPos) -> Bool = {p in false}
    ) -> Map<MapTile> {
        return MapBreadthFirstTraversal.traverse(start: start, map: self, visitor: visitor, isBlocked: isBlocked)
    }
}

