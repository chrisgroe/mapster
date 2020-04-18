//
//  Map.swift
//  mapster
//
//  Created by Christian Gröling on 14.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation


extension Map where Element == MapTile{
    
    func floodFill(
        pos: MapPos,
        visitor: (_ pos : MapPos)->MapTile,
        isBlocked: (_ pos: MapPos) -> Bool = {p in false}
    ) -> Map<MapTile> {
        return FloodFill.floodFill(start: pos, map: self, visitor: visitor, isBlocked: isBlocked)
    }
}

