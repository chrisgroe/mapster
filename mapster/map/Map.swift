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
    public typealias Vertex = MapPos
    public typealias Element = T
     
    var map : Array<Array<Element>>
    let xlen : Int
    let ylen : Int
    
    init(_ xlen: Int, _ ylen: Int, _ factory: (_ pos : MapPos)->T) {

        precondition(xlen>0, "xlen must be >0")
        precondition(ylen>0, "ylen must be >0")
        self.xlen = xlen
        self.ylen = ylen

        
        map = Array<Array<T>>(repeating: Array<T>(), count: xlen)
        for (x, var row) in map.enumerated() {
            for y in 0..<ylen {
                row.append(factory(MapPos(x:x, y:y)))
            }
            map[x] = row
        }
    }
    
    init(_ mapString : String, _ factory: (_ pos : MapPos, _ ch: Character)->T) {

        assert(mapString != "")
        
        let mapLines = mapString.split(separator: "\n")
        var chars = Array<Array<Character>>()
        
        let yl = mapLines.count
        let xl = mapLines[0].count
        
        for _ in 0..<xl {
            let row = Array<Character>(repeating: "O", count: yl)
            
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
    
    
    func isInBounds(x:Int, y:Int ) -> Bool {
        if x>=0 && x<xlen && y>=0 && y<ylen {
            return true
        }
        return false
    }
    
    
    class NeighborIterator : IteratorProtocol {

        var step : Int = 0
        var x : Int = 0
        var y : Int = 0
        var master : Map<T>
        
        init(_ x: Int, _ y : Int, _ master : Map<T>){
            self.x = x
            self.y = y
            self.master  = master
        }
   
        
        func isPassable(_ vertex : MapPos) -> Bool
        {
            if vertex.x>=0 && vertex.x<master.xlen && vertex.y>=0 && vertex.y<master.ylen {
                return true
            }
            return false
        }
        
        func next() -> MapPos? {
            while (step < 5) {
                switch (step) {
                case 0:
                    step += 1
                    let p0 = MapPos(x: x+1, y: y)
                    if isPassable(p0)  {
                        return p0
                    }
                    
                case 1:
                    step += 1
                    let p1 = MapPos(x: x, y: y+1)
                    if isPassable(p1) {
                        return(p1)
                    }
                case 2:
                    step += 1
                    let p2 = MapPos(x: x-1, y: y)
                    if isPassable(p2) {
                        return (p2)
                    }
                    
                case 3:
                    step += 1
                    let p3 = MapPos(x: x, y: y-1)
                    if isPassable(p3) {
                        return (p3)
                    }
                    
                default:
                    return nil
                }
            }
            return nil
        }
        
        
    }
    func getNeighborIterator(of vertex: MapPos) -> NeighborIterator {
        
        //           4 (y-1)
        //           |
        // (x-1) 3 - X - 1 (x+1)
        //           |
        //           2 (y+1)
        
        return NeighborIterator(vertex.x, vertex.y, self)
    }
}

extension Map {
    public func createStringView(_ mapToChar : (_ element : Element) -> Character) -> String {
        var str = ""

        for y in 0..<ylen {
            for x in 0..<xlen {

                str += String(mapToChar(self[x,y]))
            }

            if y != ylen-1 {
                str += "\n"
            }
        }
        return str
    }
}
