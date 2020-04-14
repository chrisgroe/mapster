//
//  Map.swift
//  mapster
//
//  Created by Christian Gröling on 09.04.20.
//  Copyright © 2020 Christian Gröling. All rights reserved.
//

import Foundation


public struct Map<T> : NavigatableGraph
{
    typealias Vertex = MapPos
    typealias Data = T
    
    var map : Array<Array<Data>>
    let xlen : Int
    let ylen : Int
    
    init?(_ xlen: Int, _ ylen: Int, _ factory: (_ pos : MapPos)->T) {
        
        self.xlen = xlen
        self.ylen = ylen
        guard xlen>0 && ylen>0 else {
            return nil
        }
        
        map = Array<Array<T>>()
        for x in 0..<xlen {
            var row = Array<T>()
            
            for y in 0..<ylen {
                row.append(factory(MapPos(x:x, y:y)))
            }
            
            map.append(row)
        }
    }
    
    init?(_ mapString : String, _ factory: (_ pos : MapPos, _ ch: Character)->T) {
        
        let mapLines = mapString.split(separator: "\n")
        var chars = Array<Array<Character>>()
        
        let yl = mapLines.count
        let xl = mapLines[0].count
        
        for _ in 0..<xl {
            var row = Array<Character>()
            for _ in 0..<yl {
                row.append("O")
            }
            chars.append(row)
        }
        
        for (y,row) in mapLines.enumerated() {
            for (x,ch) in row.enumerated() {
                chars[x][y] = ch
            }
        }
        
        self.init(xl,yl, {pos in
            factory(pos, chars[pos.x][pos.y])
        })
    }
    
    subscript(_ x : Int, _ y: Int) -> T? {
        
        set {
            guard let val = newValue else {
                return
            }
            guard x>=0 && x<xlen else {
                return
            }
            
            guard y>=0 && y<ylen else {
                return
            }
            map[x][y] = val
            
        }
        get {
            guard x>=0 && x<xlen else {
                return nil
            }
            
            guard y>=0 && y<ylen else {
                return nil
            }
            
            return map[x][y]
        }
    }
    
    subscript(_ pos : MapPos) -> T? {
        set {
            self[pos.x, pos.y] = newValue
        }
        
        get {
            self[pos.x, pos.y]
        }
        
    }
    
    private static func isInBounds(pos: MapPos, xlen: Int, ylen:Int ) -> Bool {
          if pos.x<0 || pos.x>=xlen || pos.y<0 || pos.y>=ylen {
              return false
          }
          return true
    }
      
    
    func getNeighbors(of vertex: Vertex) -> [Vertex] {
        
        //           4 (y-1)
        //           |
        // (x-1) 3 - X - 1 (x+1)
        //           |
        //           2 (y+1)
        
        
        // This algorithmn seems a little bit complicated since this can be done
        // with "filter". But this implementation here is a lot faster and all
        // algorithmns traversing the graph use this.
        var neighb = [Vertex]()
        neighb.reserveCapacity(4)
        
        let p0 = MapPos(x: vertex.x+1, y: vertex.y)
        if Map<T>.isInBounds(pos: p0, xlen: xlen, ylen: ylen) {
            neighb.append(p0)
        }
        let p1 = MapPos(x: vertex.x, y: vertex.y+1)
        if Map<T>.isInBounds(pos: p1, xlen: xlen, ylen: ylen) {
            neighb.append(p1)
        }
        
        let p2 = MapPos(x: vertex.x-1, y: vertex.y)
        if Map<T>.isInBounds(pos: p2, xlen: xlen, ylen: ylen) {
            neighb.append(p2)
        }
        
        let p3 = MapPos(x: vertex.x, y: vertex.y-1)
        if Map<T>.isInBounds(pos: p3, xlen: xlen, ylen: ylen) {
            neighb.append(p3)
        }
        
        return neighb
    }
    
}
