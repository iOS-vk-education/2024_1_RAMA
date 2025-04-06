//import UIKit
//import SceneKit
//
//extension MapViewController {
//    
//    func render2DMap() {
//        let scene = SCNScene()
//        for office in offices {
//            let box = SCNBox(
//                width: office.length,
//                height: 0.01,
//                length: office.height,
//                chamferRadius: 0
//            )
//
//            box.firstMaterial?.diffuse.contents = UIColor(hex: office.color)
//            let boxNode = SCNNode(geometry: box)
//            
//            // Позиционирование кабинета в пространстве
//            boxNode.position = SCNVector3(
//                CGFloat(office.coords[0]),
//                CGFloat(office.coords[1] + office.width / 2),
//                CGFloat(office.coords[2])
//            )
//
//            let textGeometry = SCNText(string: office.name, extrusionDepth: 0.1)
//            textGeometry.font = UIFont.systemFont(ofSize: 12) // Размер шрифта
//            textGeometry.firstMaterial?.diffuse.contents = UIColor.black
//            let textNode = SCNNode(geometry: textGeometry)
//            textNode.position = SCNVector3(
//                0,                              // Центр по X
//                office.coords[1] + office.width / 2 + 0.1,          // Над кубом (высота кабинета + отступ)
//                0                               // Центр по Z
//            )
//            textNode.scale = SCNVector3(0.01, 0.01, 0.01) // Масштаб текста
//            
//            textNode.eulerAngles = SCNVector3(Float(-Double.pi/2), 0, 0)
//            
//            boxNode.addChildNode(textNode)
//            scene.rootNode.addChildNode(boxNode)
//        }
//        
//        // Отрисовка точек
//        for point in points {
//            let sphere = SCNSphere(radius: 0.0001)
//            let node = SCNNode(geometry: sphere)
//            node.position = SCNVector3(point.x, point.y + 0.5, point.z)
//            node.geometry?.firstMaterial?.diffuse.contents = pointColor(for: point.type)
//            scene.rootNode.addChildNode(node)
//        }
//        
//        
//        scene2DView.scene = scene
//        setup2DCamera()
//    }
//    
//    private func setup2DCamera() {
//        let cameraNode = SCNNode()
//        cameraNode.camera = SCNCamera()
//        
//        // Позиционируем камеру строго сверху
//        cameraNode.position = SCNVector3(x: 0, y: 20, z: 0)  // y определяет высоту камеры
//        
//        // Поворачиваем камеру строго вниз (-90 градусов по оси X)
//        cameraNode.eulerAngles = SCNVector3(-Float.pi/2, 0, 0)
//        
//        // Опционально: можно сделать камеру ортографической для истинного 2D вида
//        cameraNode.camera?.usesOrthographicProjection = true
//        
//        // Настройка ортографического масштаба (подберите значение под ваши нужды)
//        cameraNode.camera?.orthographicScale = 10
//        
//        scene2DView.scene?.rootNode.addChildNode(cameraNode)
//        
//    }
//}



