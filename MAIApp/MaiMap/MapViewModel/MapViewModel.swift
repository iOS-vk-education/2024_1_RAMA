import Foundation
import SceneKit
import SwiftUI

class MapViewModel: ObservableObject {
    @Published var currentMode: MapViewController.MapMode = .mode2D
    @Published var currentFloor: Int = 1
    @Published var floors: [Int] = [1, 2, 3, 4, 5, 6]
    @Published var path: [String]? = nil
    @Published var offices: [Office] = []
    @Published var points: [Point] = []
    @Published var verticalConnections: [VerticalConnection] = []
    
    @Published var fromRoom: String = ""
    @Published var toRoom: String = ""
    @Published var fromFloor: Int = 1
    @Published var toFloor: Int = 1
    
    var routeCalculator: RouteCalculator?
    
    init() {
        loadData()
    }
    
    func loadData() {
        offices.removeAll()
        points.removeAll()
        verticalConnections.removeAll()

        if let connections: [VerticalConnection] = JSONLoader.load("all_vertical_connections.json") {
            verticalConnections = connections
        }
        

        let fileNames = ["test_map1.json", "test_map2.json", "test_map3.json", "test_map4.json", "test_map5.json", "test_map6.json"]
        for (index, fileName) in fileNames.enumerated() {
            if let floorData: FloorData = JSONLoader.load(fileName) {
                offices.append(contentsOf: floorData.offices)
                points.append(contentsOf: floorData.nodes.filter { $0.floor == index + 1 })
            }
        }

        processVerticalConnections()
        routeCalculator = RouteCalculator(points: points, verticalConnections: verticalConnections)
    }
    
    private func processVerticalConnections() {
        for connection in verticalConnections {
            guard connection.nodes.count == 2 else { continue }
            
            if let node1Index = points.firstIndex(where: { $0.id == connection.nodes[0] }),
               let node2Index = points.firstIndex(where: { $0.id == connection.nodes[1] }) {
                points[node1Index].connections.append(connection.nodes[1])
                points[node2Index].connections.append(connection.nodes[0])
            }
        }
    }
    
    func findPath(from startId: String, to endId: String) {
        guard let calculator = routeCalculator else {
            print("RouteCalculator не инициализирован")
            return
        }
        let calculatedPath = calculator.findPath(from: startId, to: endId)
        DispatchQueue.main.async {
            self.path = calculatedPath
            print("Path assigned: \(String(describing: self.path))")
        }
    }
    
    func officesForFloor(_ floor: Int) -> [Office] {
        let pointsForFloor = points.filter { $0.floor == floor }
        
        let officeIds = pointsForFloor
            .filter { $0.type == "room" || $0.type == "elevator" || $0.type == "stairs" }
            .map { $0.id.replacingOccurrences(of: "office_", with: "") }
        
        return offices.filter { office in
            officeIds.contains { id in
                office.name.lowercased().contains(id.lowercased()) || office.name == id
            }
        }
    }
}
