//
//  Point.swift
//  MaiMap
//
//  Created by Михаил Рахимов on 13.02.2025.
//

import Foundation

struct Point: Codable {
    let x: CGFloat
    let y: CGFloat
    let z: CGFloat
    var connections: [String]
    let floor: Int
    let id: String
    let type: String
    let landmarks: [String]
    let name: String
    
    
    //    static func == (lhs: Point, rhs: Point) -> Bool {
    //        return lhs.id == rhs.id
    //    }
    //
    //    func hash(into hasher: inout Hasher) {
    //        hasher.combine(id)
    //    }
    //
    
}
    struct Office: Codable {
        let length: CGFloat
        let width: CGFloat
        let height: CGFloat
        let name: String
        let color: String
        let coords: [CGFloat]
        let type: String?
    }
    
    struct VerticalConnection: Codable {
        let type: String
        let name: String
        let nodes: [String]
        let weight: Int
    }
    
    struct FloorData: Codable {
        let offices: [Office]
        let nodes: [Point]
    }
    
   
    
    
    






