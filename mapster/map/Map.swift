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
        map.reserveCapacity(ylen)
        for x in 0..<xlen {
            var row = Array<T>()
            row.reserveCapacity(xlen)
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
    
    subscript(_ x : Int, _ y: Int) -> T {
        
        set {
            assert(x>=0 && x<xlen)
            assert(y>=0 && y<ylen)
            map[x][y] = newValue
            
        }
        get {
            assert(x>=0 && x<xlen)
            assert(y>=0 && y<ylen)
            return map[x][y]
        }
    }
    
    subscript(_ pos : MapPos) -> T {
        set {
            self[pos.x, pos.y] = newValue
        }
        
        get {
            self[pos.x, pos.y]
        }
        
    }
    

    private  func isInBounds(x:Int, y:Int ) -> Bool {
          if x>=0 && x<xlen && y>=0 && y<ylen {
              return true
          }
          return false
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
        
        if isInBounds(x: vertex.x+1, y: vertex.y) {
            neighb.append(MapPos(x: vertex.x+1, y: vertex.y))
        }
        if isInBounds(x: vertex.x, y: vertex.y+1) {
            neighb.append(MapPos(x: vertex.x, y: vertex.y+1))
        }
        if isInBounds(x: vertex.x-1, y: vertex.y) {
            neighb.append(MapPos(x: vertex.x-1, y: vertex.y))
        }
        if isInBounds(x: vertex.x, y: vertex.y-1) {
            neighb.append(MapPos(x: vertex.x, y: vertex.y-1))
        }
        
        return neighb
    }
    
}
