//
//  MapViewController.swift
//  MaiMap
//
//  Created by Михаил Рахимов on 13.02.2025.
//

import UIKit
import SpriteKit
import SceneKit

class MapViewController: UIViewController {
    enum MapMode {
            case mode2D
            case mode3D
    }
        
    // MARK: - Data
    var cameraNode: SCNNode! = nil
    var offices: [Office] = []
    var points: [Point] = []
    var verticalConnections: [VerticalConnection] = []
    var currentFloor: Int = 1
    var currentMode: MapMode = .mode2D {
        didSet {
            updateViewForCurrentMode()
        }
    }
    
    private var routeCalculator: RouteCalculator?
    
    // MARK: - UI Components
        let scene3DView: SCNView = {
            let view = SCNView()
            view.backgroundColor = .systemGray6
            view.autoenablesDefaultLighting = true
            view.allowsCameraControl = true
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        let scene2DView: SCNView = {
            let view = SCNView()
            view.backgroundColor = .systemGray6
            view.autoenablesDefaultLighting = true
            view.allowsCameraControl = false
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        // MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            loadData()
            updateViewForCurrentMode()
        }
        
        // MARK: - UI Setup
        private func setupUI() {
            view.backgroundColor = .systemBackground
            view.addSubview(scene3DView)
            view.addSubview(scene2DView)
            
            NSLayoutConstraint.activate([
                scene3DView.topAnchor.constraint(equalTo: view.topAnchor),
                scene3DView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scene3DView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scene3DView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                scene2DView.topAnchor.constraint(equalTo: scene3DView.topAnchor),
                scene2DView.leadingAnchor.constraint(equalTo: scene3DView.leadingAnchor),
                scene2DView.trailingAnchor.constraint(equalTo: scene3DView.trailingAnchor),
                scene2DView.bottomAnchor.constraint(equalTo: scene3DView.bottomAnchor)
            ])
        }
        
        // MARK: - Scene Management
        func updateViewForCurrentMode() {
            switch currentMode {
            case .mode2D:
                scene2DView.isHidden = false
                scene3DView.isHidden = true
                render2DMap()
            case .mode3D:
                scene2DView.isHidden = true
                scene3DView.isHidden = false
                render3DMap()
            }
        }

    
    // MARK: - Data Loading
    func loadData() {
        offices.removeAll()
        points.removeAll()
        verticalConnections.removeAll()

        if let connections: [VerticalConnection] = JSONLoader.load("all_vertical_connections.json") {
            self.verticalConnections = connections
        }

        var fileName = "test_map1.json"
        switch currentFloor {
        case 1:
            fileName = "test_map1.json"
        case 2:
            fileName = "test_map2.json"
        case 3:
            fileName = "test_map3.json"
        case 4:
            fileName = "test_map4.json"
        case 5:
            fileName = "test_map5.json"
        case 6:
            fileName = "test_map6.json"
        default:
            break
        }
        
        if let floorData: FloorData = JSONLoader.load(fileName) {
            offices = floorData.offices
            points = floorData.nodes.filter { $0.floor == currentFloor }
        }

        processVerticalConnections()

        routeCalculator = RouteCalculator(points: points, verticalConnections: verticalConnections)
        
        print("Данные загружены:")
        print("Офисов: \(offices.count)")
        print("Точек: \(points.count)")
        print("Соединений: \(verticalConnections.count)")
    }
    
    private func loadFloorData(floor: Int, file: String) {
        if let floorOffices: [Office] = JSONLoader.load(file) {
            self.offices.append(contentsOf: floorOffices)
        } else {
            print("Ошибка загрузки офисов для этажа \(floor)")
        }
        
        if var floorPoints: [Point] = JSONLoader.load(file) {
            floorPoints = floorPoints.filter { $0.floor == floor }
            self.points.append(contentsOf: floorPoints)
        } else {
            print("Ошибка загрузки точек для этажа \(floor)")
        }
    }
    
    private func processVerticalConnections() {
        for connection in verticalConnections {
            guard connection.nodes.count == 2 else { continue }
            
            let node1 = points.first { $0.id == connection.nodes[0] }
            let node2 = points.first { $0.id == connection.nodes[1] }
            
            if let node1 = node1, let node2 = node2 {
                var updatedNode1 = node1
                var updatedNode2 = node2
                
                updatedNode1.connections.append(node2.id)
                updatedNode2.connections.append(node1.id)
                
                if let index1 = points.firstIndex(where: { $0.id == node1.id }) {
                    points[index1] = updatedNode1
                }
                if let index2 = points.firstIndex(where: { $0.id == node2.id }) {
                    points[index2] = updatedNode2
                }
            }
        }
    }
    
    // MARK: - Actions
    
    private func setupGestures() {
        //масштабирование
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        view.addGestureRecognizer(pinchGesture)
        
        //перемещение
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        let scale = Float(gesture.scale)
        
        if currentMode == .mode3D {
            let currentScale = scene3DView.pointOfView?.scale.x ?? 1.0
            let newScale = currentScale * scale
            
            scene3DView.pointOfView?.scale = SCNVector3(
                x: max(min(newScale, 3.0), 0.5),
                y: max(min(newScale, 3.0), 0.5),
                z: max(min(newScale, 3.0), 0.5)
            )
            
        } else {
            guard let camera = scene2DView.pointOfView?.camera else { return }
            let currentScale = camera.orthographicScale
            let newScale = currentScale / Double(scale)
            
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.3
            SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: .linear)
            
            camera.orthographicScale = max(min(newScale, 20.0), 5.0)
            
            SCNTransaction.commit()
        }
        
        gesture.scale = 1.0
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var sensitivity: Float = 0.01
        
        if currentMode == .mode3D {
            guard let camera = scene3DView.pointOfView else { return }
            let currentPosition = camera.position
            var newPosition = SCNVector3(
                currentPosition.x + Float(translation.x) * sensitivity,
                currentPosition.y,
                currentPosition.z - Float(translation.y) * sensitivity
            )

            newPosition.y = max(newPosition.y, 5.0)

            camera.position = newPosition
        } else {
            guard let currentPosition = scene2DView.pointOfView?.position else { return }
            sensitivity = 0.04
            
            let newPosition = SCNVector3(
                x: currentPosition.x - Float(translation.x) * sensitivity,
                y: currentPosition.y,
                z: currentPosition.z - Float(translation.y) * sensitivity
            )
            
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.15
            SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: .easeOut)
            
            scene2DView.pointOfView?.position = newPosition
            
            SCNTransaction.commit()
        }
        
        gesture.setTranslation(.zero, in: view)
    }


    @objc private func resetCamera() {
        if currentMode == .mode3D {
            scene3DView.pointOfView?.position = SCNVector3(x: 0, y: 30, z: 15)
            scene3DView.pointOfView?.eulerAngles = SCNVector3(-Float.pi/4, 0, 0)
            scene3DView.pointOfView?.scale = SCNVector3(1, 1, 1)
        } else {
            scene2DView.pointOfView?.position = SCNVector3(x: 0, y: 20, z: 0)
            scene2DView.pointOfView?.eulerAngles = SCNVector3(-Float.pi/2, 0, 0)
            scene2DView.pointOfView?.camera?.orthographicScale = 10
        }
    }


}

// MARK: - Color Helpers
extension MapViewController {
    func pointColor(for type: String) -> UIColor {
        switch type {
        case "elevator":
            return .systemBlue
        case "stairs":
            return .systemGreen
        case "room":
            return .systemOrange
        case "corridor":
            return .systemGray
        case "entrance":
            return .systemRed
        default:
            return .systemPurple
        }
    }
}

