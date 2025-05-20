import UIKit
import SceneKit
import Foundation

class MapViewController: UIViewController {
    enum MapMode {
        case mode2D
        case mode3D
    }
    
    // MARK: - Data
    var currentMode: MapMode = .mode2D
    var currentFloor: Int = 1
    var offices: [Office] = []
    var points: [Point] = []
    var verticalConnections: [VerticalConnection] = []
    var path: [String]?
    var cameraScale: Double = 10.0
    var cameraPosition: SCNVector3 = SCNVector3(0, 20, 0)
    
    private var routeCalculator: RouteCalculator?
    private var pathAnimationProgress: CGFloat = 0.0
    private var pathAnimationTimer: CADisplayLink?
    private var pathNode: SCNNode?
    
    // MARK: - UI Components
    let scene3DView: SCNView = {
        let view = SCNView()
        view.backgroundColor = .systemGray6
        view.autoenablesDefaultLighting = false
        view.allowsCameraControl = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let scene2DView: SCNView = {
        let view = SCNView()
        view.backgroundColor = .systemGray6
        view.autoenablesDefaultLighting = false
        view.allowsCameraControl = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
//        scene3DView.allowsCameraControl = true
//        if #available(iOS 11.0, *) {
//            scene3DView.defaultCameraController.interactionMode      = .orbitTurntable
//            scene3DView.defaultCameraController.minimumVerticalAngle = -Float.pi/3
//            scene3DView.defaultCameraController.maximumVerticalAngle =  Float.pi/3
//        }
        
        loadData()
        setupGestures()
        updateViewForCurrentMode()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopPathAnimation() 
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
        print("Вывод карты для режима: \(currentMode) время: \(Date())")
        switch currentMode {
        case .mode2D:
            scene2DView.isHidden = false
            scene3DView.isHidden = true
            scene2DView.gestureRecognizers?.forEach { $0.isEnabled = true }
            render2DMap()
        case .mode3D:
            scene2DView.isHidden = true
            scene3DView.isHidden = false
            scene2DView.gestureRecognizers?.forEach { $0.isEnabled = false }
            render3DMap()
        }
    }
    

    private func render2DMap() {
        let scene = SCNScene()
        scene.rootNode.enumerateChildNodes { (node, _) in
                node.removeFromParentNode()
        }
        for office in offices {
            let box = SCNBox(
                width: office.length,
                height: 0.01,
                length: office.height,
                chamferRadius: 0
            )

            box.firstMaterial?.diffuse.contents = UIColor(hex: office.color)
            let boxNode = SCNNode(geometry: box)
            
    
            boxNode.position = SCNVector3(
                CGFloat(office.coords[0]),
                CGFloat(office.coords[1] + office.width / 2),
                CGFloat(office.coords[2])
            )

            let textGeometry = SCNText(string: office.name, extrusionDepth: 0.1)
            textGeometry.font = UIFont.systemFont(ofSize: 12)
            textGeometry.firstMaterial?.diffuse.contents = UIColor.black
            let textNode = SCNNode(geometry: textGeometry)
            textNode.position = SCNVector3(
                0,                                                  // Центр по X
                office.coords[1] + office.width / 2 + 0.1,          // Над кубом (высота кабинета + отступ)
                0                                                   // Центр по Z
            )
            textNode.scale = SCNVector3(0.015, 0.015, 0.015)        // Масштаб текста
            
            textNode.eulerAngles = SCNVector3(Float(-Double.pi/2), 0, 0)
            
            boxNode.addChildNode(textNode)
            scene.rootNode.addChildNode(boxNode)
        }
        
        // Отрисовка точек
        for point in points {
            let sphere = SCNSphere(radius: 0.0001)
            let node = SCNNode(geometry: sphere)
            node.position = SCNVector3(point.x, point.y + 0.5, point.z)
            node.geometry?.firstMaterial?.diffuse.contents = pointColor(for: point.type)
            scene.rootNode.addChildNode(node)
        }
//        print("Path to render: \(String(describing: path))")
        // Отрисовка пути
        if let path = path {
            renderPath(path, in: scene, mode: .mode2D)
        }
        
        // Настройка камеры
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = cameraPosition
        cameraNode.eulerAngles = SCNVector3(-CGFloat.pi / 2, 0, 0)
        cameraNode.camera?.usesOrthographicProjection = true
        cameraNode.camera?.orthographicScale = cameraScale
        scene.rootNode.addChildNode(cameraNode)
        
        scene2DView.scene = scene
        scene2DView.pointOfView = cameraNode

    }
    
  
    private func render3DMap() {
        let scene = SCNScene()
        print("Cleaning scene, removing \(scene.rootNode.childNodes.count) nodes")
        scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        print("Scene cleaned, remaining nodes: \(scene.rootNode.childNodes.count)")
        
        for office in offices {
            let box = SCNBox(
                width: office.length,
                height: office.width,
                length: office.height,
                chamferRadius: 0
            )
            
//            box.firstMaterial?.diffuse.contents = UIColor(hex: office.color)
            let material = SCNMaterial()
            material.diffuse.contents = UIColor(hex: office.color)
            material.specular.contents = UIColor.white
            material.specular.intensity = 0.2
            material.roughness.contents = 0.7
            material.lightingModel = .phong
                
            box.materials = [material]
            
            let boxNode = SCNNode(geometry: box)
            let officeId = office.name
            boxNode.name = "office_\(officeId)"
            
            boxNode.castsShadow = true
            
            boxNode.position = SCNVector3(
                CGFloat(office.coords[0]),
                CGFloat(office.coords[1] + office.width / 2),
                CGFloat(office.coords[2])
            )
            
            let textGeometry = SCNText(string: office.name, extrusionDepth: 0.1)
            textGeometry.font = UIFont.systemFont(ofSize: 12) // Размер шрифта
            textGeometry.firstMaterial?.diffuse.contents = UIColor.black
            
            textGeometry.alignmentMode = CATextLayerAlignmentMode.center.rawValue
            
            let textNode = SCNNode(geometry: textGeometry)
        
            
            let centerOfBox = sqrt(pow(office.length, 2) + pow(office.height, 2)) / 2
            print(centerOfBox, "office_\(officeId)")
            
            
            textNode.position = SCNVector3(
                0,                                                  // Центр по X
                office.coords[1] + office.width / 2,                // Над кубом (высота кабинета + отступ)
                0                                                   // Центр по Z
            )
            textNode.scale = SCNVector3(0.015, 0.015, 0.015)
            
            textNode.eulerAngles = SCNVector3(Float(-Double.pi/2), 0, 0)
            
//            textNode.pivot = SCNMatrix4MakeTranslation(0.5, 0.5, 0)

            print("Text position for \(office.name): \(textNode.position)")
            
            // Добавляем новый текст
            boxNode.addChildNode(textNode)
            scene.rootNode.addChildNode(boxNode)

        }
        
        // Рендеринг точек
        for point in points {
            let sphere = SCNSphere(radius: 0.2)
            let node = SCNNode(geometry: sphere)
            node.position = SCNVector3(point.x, point.y + 0.5, point.z)
            node.geometry?.firstMaterial?.diffuse.contents = pointColor(for: point.type)
            let pointId = point.id
            node.name = "point_\(pointId)"
            node.castsShadow = false
            
            if let name = node.name, scene.rootNode.childNode(withName: name, recursively: false) == nil {
                scene.rootNode.addChildNode(node)
            } else {
                print("Skipping duplicate point node with name: \(node.name ?? "nil")")
            }
        }
        
        print("Path to render: \(String(describing: path))")
        if let path = path {
            renderPath(path, in: scene, mode: .mode3D)
        }
        
        setupLighting(scene: scene, mode: .mode3D)
        let cameraNode = setupCamera(for: scene, mode: .mode3D)
        scene3DView.scene = scene
        
        
        scene3DView.pointOfView = cameraNode
//        setupCameraConstraints()
       
    }
    
    private func setup3DCamera() {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 15, z: 15)
        cameraNode.eulerAngles = SCNVector3(-Float.pi/4, 0, 0)
        scene3DView.scene?.rootNode.addChildNode(cameraNode)
    }
    
//    private func setupCameraConstraints() {
//        scene3DView.allowsCameraControl = true
//        scene3DView.defaultCameraController.interactionMode = .orbitTurntable
//        scene3DView.defaultCameraController.minimumVerticalAngle = -Float.pi/3
//        scene3DView.defaultCameraController.maximumVerticalAngle =  Float.pi/3
//
//    }
//    
    private func setupCamera(for scene: SCNScene, mode: MapMode) -> SCNNode {
            let cameraNode = SCNNode()
            cameraNode.camera = SCNCamera()

            let allPositions = offices.map { SCNVector3($0.coords[0], $0.coords[1], $0.coords[2]) } + points.map { SCNVector3($0.x, $0.y, $0.z) }
            let center = allPositions.reduce(SCNVector3Zero) { SCNVector3($0.x + $1.x, $0.y + $1.y, $0.z + $1.z) }
            let sceneCenter = SCNVector3(center.x / Float(allPositions.count), center.y / Float(allPositions.count), center.z / Float(allPositions.count))

            if mode == .mode2D {
                cameraNode.position = SCNVector3(sceneCenter.x, sceneCenter.y + 20, sceneCenter.z)
                cameraNode.eulerAngles = SCNVector3(-CGFloat.pi / 2, 0, 0)
                cameraNode.camera?.usesOrthographicProjection = true
                cameraNode.camera?.orthographicScale = 20.0
            } else {
                cameraNode.position = SCNVector3(sceneCenter.x + 10, sceneCenter.y + 10, sceneCenter.z + 10)
                
                cameraNode.look(at: sceneCenter)
                cameraNode.camera?.orthographicScale = 30.0
                cameraNode.camera?.usesOrthographicProjection = false
//                
//                cameraNode.camera?.zNear = 1
//                cameraNode.camera?.zFar = 100000
            }

            scene.rootNode.addChildNode(cameraNode)
            return cameraNode
    }
    
    private func setupLighting(scene: SCNScene, mode: MapMode) {
        scene.rootNode.childNodes.filter { $0.light != nil }.forEach { $0.removeFromParentNode() }
        
        if mode == .mode2D {
            let ambientLightNode = SCNNode()
            ambientLightNode.light = SCNLight()
            ambientLightNode.light?.type = .ambient
            ambientLightNode.light?.color = UIColor.white
            ambientLightNode.light?.intensity = Double.pi / 2.0
            scene.rootNode.addChildNode(ambientLightNode)
        }
        
        else {
            let ambientLightNode = SCNNode()
            ambientLightNode.light = SCNLight()
            ambientLightNode.light?.type = .ambient
            ambientLightNode.light?.color = UIColor(white: 0.3, alpha: 1.0) // Неяркий белый
            ambientLightNode.light?.intensity = 1000 // Стандартная интенсивность
            scene.rootNode.addChildNode(ambientLightNode)
            
            let directionalLight = SCNNode()
            directionalLight.light = SCNLight()
            directionalLight.light?.type = .directional
            directionalLight.light?.color = UIColor(white: 0.8, alpha: 1.0)
            directionalLight.light?.intensity = 1500
            directionalLight.light?.castsShadow = true
            
            directionalLight.light?.shadowMode = .forward
            directionalLight.light?.shadowMapSize = CGSize(width: 2048, height: 2048)
            directionalLight.light?.shadowBias = 2.0
            directionalLight.light?.maximumShadowDistance = 100
            
            directionalLight.position = SCNVector3(-15, 25, 15)
            directionalLight.look(at: SCNVector3(0, 0, 0))
            
            
            scene.rootNode.addChildNode(directionalLight)
            
    }
}
    
    private func renderPath(_ path: [String], in scene: SCNScene, mode: MapMode) {
        scene.rootNode.childNodes.filter { $0.name == "path" }.forEach { $0.removeFromParentNode() }
        
        var routePoints: [SCNVector3] = []
        for nodeId in path {
            if let node = points.first(where: { $0.id == nodeId }) {
                let y = mode == .mode2D ? node.y + 1.0 : node.y + 1
                routePoints.append(SCNVector3(CGFloat(node.x), y, CGFloat(node.z)))
            }
        }
//        print("Route points: \(routePoints)")
        guard routePoints.count >= 2 else { return }
        
        // Создаем сглаженные точки для более плавного пути
        let smoothPoints = createSmoothPoints(from: routePoints, segments: max(200, routePoints.count * 40))
        
        // Создаем контейнерный узел для всех сегментов пути
        let pathContainer = SCNNode()
        pathContainer.name = "path"
        
        // Создаем сегменты пути из трубок вместо линий
        for i in 0..<(smoothPoints.count - 1) {
            let startPoint = smoothPoints[i]
            let endPoint = smoothPoints[i + 1]
            
            // Вычисляем направление и длину сегмента
            let direction = SCNVector3(
                endPoint.x - startPoint.x,
                endPoint.y - startPoint.y,
                endPoint.z - startPoint.z
            )
            let length = sqrt(
                pow(Double(direction.x), 2) +
                pow(Double(direction.y), 2) +
                pow(Double(direction.z), 2)
            )
            
            // Создаем цилиндр для сегмента
            let tube = SCNCylinder(radius: 0.05, height: CGFloat(length))
            let tubeNode = SCNNode(geometry: tube)
            tubeNode.castsShadow = false
            
            // Устанавливаем цвет и свойства материала
            let material = SCNMaterial()
            material.diffuse.contents = UIColor.red
            material.emission.contents = UIColor.red
            tube.materials = [material]
            
            // Позиционируем и ориентируем цилиндр
            tubeNode.position = SCNVector3(
                (startPoint.x + endPoint.x) / 2,
                (startPoint.y + endPoint.y) / 2,
                (startPoint.z + endPoint.z) / 2
            )
            
            // Ориентация цилиндра по умолчанию - вдоль оси Y
            // Нам нужно повернуть его, чтобы он был направлен от startPoint к endPoint
            
            // Угол поворота вокруг оси X (в плоскости YZ)
            let xAngle = atan2(direction.z, direction.y) - .pi/2
            // Угол поворота вокруг оси Z (в плоскости XY)
            let zAngle = atan2(direction.x, direction.y) - .pi/2
            
            // Сначала поворачиваем вокруг оси X
            tubeNode.eulerAngles.x = xAngle
            // Затем поворачиваем вокруг оси Z
            tubeNode.eulerAngles.z = zAngle
            
            // Если направление в основном горизонтальное, используем другой метод ориентации
            if abs(direction.y) < 0.001 {
                // Определяем ось поворота (перпендикулярную к горизонтальному направлению)
                _ = SCNVector3(0, 1, 0)
                // Угол поворота в горизонтальной плоскости
                let angle = atan2(direction.x, direction.z)
                tubeNode.eulerAngles = SCNVector3(0, angle, .pi/2)
            }
            
            // Начинаем с нулевой прозрачности для анимации
            tubeNode.geometry?.firstMaterial?.transparency = 0.0
            
            tubeNode.castsShadow = false
            pathContainer.addChildNode(tubeNode)
        }
        
        scene.rootNode.addChildNode(pathContainer)
        self.pathNode = pathContainer
        startPathAnimation()
    }
    
    private func createSmoothPoints(from points: [SCNVector3], segments: Int) -> [SCNVector3] {
        guard points.count >= 2 else { return points }
        
        var smoothPoints: [SCNVector3] = []
        let totalSegments = max(2, segments)
        
        for i in 0..<points.count - 1 {
            let start = points[i]
            let end = points[i + 1]
            let step = 1.0 / CGFloat(totalSegments / (points.count - 1))
            
            for j in 0...Int(totalSegments / (points.count - 1)) {
                let t = CGFloat(j) * step
                let x = (start.x + (end.x - start.x) * Float(t))
                let y = (start.y + (end.y - start.y) * Float(t))
                let z = (start.z + (end.z - start.z) * Float(t))
                smoothPoints.append(SCNVector3(x, y, z))
            }
        }
        
        return smoothPoints
    }
    
    private func startPathAnimation() {
        stopPathAnimation()
        pathAnimationProgress = 0.0
        
        // Устанавливаем прозрачность для всех дочерних узлов
        pathNode?.childNodes.forEach { node in
            node.geometry?.firstMaterial?.transparency = 0.0
        }
        
        pathAnimationTimer = CADisplayLink(target: self, selector: #selector(updatePathAnimation))
        pathAnimationTimer?.add(to: .main, forMode: .common)
    }

    private func stopPathAnimation() {
        pathAnimationTimer?.invalidate()
        pathAnimationTimer = nil
        
        pathNode?.childNodes.forEach { node in
            node.geometry?.firstMaterial?.transparency = 1.0
        }
    }

    @objc private func updatePathAnimation() {
        pathAnimationProgress = min(pathAnimationProgress + 0.02, 1.0) // Быстрая анимация
        
        // Обновляем прозрачность для всех дочерних узлов
        pathNode?.childNodes.forEach { node in
            node.geometry?.firstMaterial?.transparency = pathAnimationProgress
        }
        
        if pathAnimationProgress >= 1.0 {
            stopPathAnimation()
        }
    }

 
    
    // MARK: - Gestures
    private func setupGestures() {
        // Масштабирование
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        scene2DView.addGestureRecognizer(pinchGesture)
       
        
        // Перемещение
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        scene2DView.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        let scale = Float(gesture.scale)
        
 
        guard let camera = scene2DView.pointOfView?.camera else { return }
        let currentScale = camera.orthographicScale
        let newScale = currentScale / Double(scale)
        
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.1
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: .easeOut)
        
        camera.orthographicScale = max(min(newScale, 20.0), 3.0)
        
        SCNTransaction.commit()
        
        
        gesture.scale = 1.0
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: scene2DView)
        var sensitivity: Float = 0.01
        
       
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
        
        
        gesture.setTranslation(.zero, in: view)
    }
    
    @objc private func resetCamera() {
        
        if currentMode == .mode3D {
            scene3DView.pointOfView?.position = SCNVector3(x: 0, y: 30, z: 15)
            scene3DView.pointOfView?.eulerAngles = SCNVector3(-Float.pi / 4, 0, 0)
            scene3DView.pointOfView?.scale = SCNVector3(1, 1, 1)
        } else {
            scene2DView.pointOfView?.position = SCNVector3(x: 0, y: 20, z: 0)
            scene2DView.pointOfView?.eulerAngles = SCNVector3(-Float.pi / 2, 0, 0)
            scene2DView.pointOfView?.camera?.orthographicScale = 10
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
        case 1: fileName = "test_map1.json"
        case 2: fileName = "test_map2.json"
        case 3: fileName = "test_map3.json"
        case 4: fileName = "test_map4.json"
        case 5: fileName = "test_map5.json"
        case 6: fileName = "test_map6.json"
        default: break
        }
        
        if let floorData: FloorData = JSONLoader.load(fileName) {
            offices = floorData.offices
            points = floorData.nodes.filter { $0.floor == currentFloor }
        }

        processVerticalConnections()
        routeCalculator = RouteCalculator(points: points, verticalConnections: verticalConnections)
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
    
    
}





