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
    
   
    
    
    






