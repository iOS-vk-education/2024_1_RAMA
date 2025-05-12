//
//  Map3DView.swift
//  MaiMap
//
//  Created by Михаил Рахимов on 13.02.2025.
//
//
//import Foundation
//import SceneKit
//
//extension MapViewController {
//    
//    func render3DMap() {
//        let scene = SCNScene()
//        for office in offices {
//            let box = SCNBox(
//                width: office.length,
//                height: office.width,
//                length: office.height,
//                chamferRadius: 0
//            )
//
//            box.firstMaterial?.diffuse.contents = UIColor(hex: office.color)
//            let boxNode = SCNNode(geometry: box)
//
//            boxNode.position = SCNVector3(
//                CGFloat(office.coords[0]),
//                CGFloat(office.coords[1] + office.width / 2),
//                CGFloat(office.coords[2])
//            )
//
//            let textGeometry = SCNText(string: office.name, extrusionDepth: 0.1)
//            textGeometry.font = UIFont.systemFont(ofSize: 12)
//            textGeometry.firstMaterial?.diffuse.contents = UIColor.black
//            
//            let textNode = SCNNode(geometry: textGeometry)
//            textNode.position = SCNVector3(
//                0,
//                office.coords[1] + office.width / 2 + 0.1,
//                0
//            )
//            textNode.scale = SCNVector3(0.01, 0.01, 0.01)
//            
//            textNode.eulerAngles = SCNVector3(Float(-Double.pi/2), 0, 0)
//            
//            boxNode.addChildNode(textNode)
//            scene.rootNode.addChildNode(boxNode)
//        }
// 
//        for point in points {
//            let sphere = SCNSphere(radius: 0.2)
//            let node = SCNNode(geometry: sphere)
//            node.position = SCNVector3(point.x, point.y + 0.5, point.z)
//            node.geometry?.firstMaterial?.diffuse.contents = pointColor(for: point.type)
//            scene.rootNode.addChildNode(node)
//        }
//        scene3DView.scene = scene
//        setup3DCamera()
//    }
//    
//    private func setup3DCamera() {
//        let cameraNode = SCNNode()
//        cameraNode.camera = SCNCamera()
//        cameraNode.position = SCNVector3(x: 0, y: 15, z: 15)
//        cameraNode.eulerAngles = SCNVector3(-Float.pi/4, 0, 0)
//        scene3DView.scene?.rootNode.addChildNode(cameraNode)
//    }
//}
