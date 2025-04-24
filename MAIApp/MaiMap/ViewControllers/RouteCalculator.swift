//
//  RouteCalculator.swift
//  MaiMap
//
//  Created by Михаил Рахимов on 13.02.2025.
//

import Foundation
import SceneKit

class RouteCalculator {
    private var points: [Point]
    private var graph: [String: [String: Double]] = [:]
    private var verticalConnections: [VerticalConnection]

    init(points: [Point], verticalConnections: [VerticalConnection]) {
        self.points = points
        self.verticalConnections = verticalConnections
        buildGraph()
    }

    /// Построение графа на основе узлов и вертикальных соединений
    private func buildGraph() {
        graph.removeAll()

        for point in points {
            graph[point.id] = [:]
        }

        for point in points {
            for connId in point.connections {
                if let neighbor = points.first(where: { $0.id == connId }) {
                    let distance = calculateDistance(point, neighbor)
                    graph[point.id]?[connId] = distance
                    graph[connId]?[point.id] = distance
//                    print("Связь: \(point.id) <-> \(connId), расстояние: \(distance)")
                } else {
                    print("Невалидная связь: \(point.id) -> \(connId)")
                }
            }
        }
        
        // Вертикальные связи
        for connection in verticalConnections {
            guard connection.nodes.count == 2,
                  let node1 = points.first(where: { $0.id == connection.nodes[0] }),
                  let node2 = points.first(where: { $0.id == connection.nodes[1] }) else { continue }
            let weight = CGFloat(connection.weight)
            graph[connection.nodes[0]]?[connection.nodes[1]] = weight
            graph[connection.nodes[1]]?[connection.nodes[0]] = weight
//            print("Вертикальная связь: \(connection.nodes[0]) <-> \(connection.nodes[1]), вес: \(weight)")
        }
//        print("Полный граф: \(graph)")
    }
    /// Расчет евклидова расстояния между двумя узлами на одном этаже
    private func calculateDistance(_ a: Point, _ b: Point) -> CGFloat {
        let dx = a.x - b.x
        let dy = a.y - b.y
        return sqrt(dx * dx + dy * dy) // 2D-расстояние
    }

    /// Поиск пути между двумя узлами с помощью алгоритма A*
    func findPath(from startId: String, to endId: String) -> [String]? {
        guard let start = points.first(where: { $0.id == startId }),
              let end = points.first(where: { $0.id == endId }) else {
//            print("Точка \(startId) или \(endId) не найдена")
            return nil
        }
        print("Поиск пути от \(startId) до \(endId)")

        var openSet = Set<String>([startId])
        var cameFrom: [String: String] = [:]
        var gScore: [String: CGFloat] = [startId: 0]
        var fScore: [String: CGFloat] = [startId: heuristic(start, end)]
        var visited: Set<String> = []

        while !openSet.isEmpty {
            let currentId = openSet.min(by: { fScore[$0, default: .infinity] < fScore[$1, default: .infinity] })!
            if currentId == endId {
                let path = reconstructPath(cameFrom: cameFrom, currentId: currentId)
                print("Путь найден: \(path)")
                return path
            }

            openSet.remove(currentId)
            visited.insert(currentId)

            guard let neighbors = graph[currentId] else { continue }

            for (neighborId, weight) in neighbors {
                if visited.contains(neighborId) { continue }

                let tentativeGScore = gScore[currentId, default: .infinity] + weight
                if tentativeGScore < gScore[neighborId, default: .infinity] {
                    cameFrom[neighborId] = currentId
                    gScore[neighborId] = tentativeGScore
                    guard let neighborPoint = points.first(where: { $0.id == neighborId }) else { continue }
                    fScore[neighborId] = tentativeGScore + heuristic(neighborPoint, end)
                    openSet.insert(neighborId)
                }
            }
        }
        print("Путь не найден. Посещено: \(visited.count) узлов")
        return nil
    }

    /// Эвристическая функция (2D-расстояние + штраф за разницу этажей)
    private func heuristic(_ a: Point, _ b: Point) -> CGFloat {
        let dx = a.x - b.x
        let dy = a.y - b.y
        let dz = CGFloat(abs(a.floor - b.floor)) * 5.0
        return sqrt(dx * dx + dy * dy) + abs(dz)
    }

    /// Восстановление пути из словаря cameFrom
    private func reconstructPath(cameFrom: [String: String], currentId: String) -> [String] {
        var path = [currentId]
        var current = currentId
        while let next = cameFrom[current] {
            current = next
            path.insert(current, at: 0)
        }
        return path
    }

    /// Генерация текстовых инструкций на основе пути
    func generateInstructions(path: [String]) -> [String] {
        var instructions: [String] = []
        var previousDirection: String? = nil

        for i in 0..<path.count {
            let currentNodeId = path[i]
            guard let currentNode = points.first(where: { $0.id == currentNodeId }) else { continue }

            if i == path.count - 1 {
                instructions.append("Вы прибыли в \(currentNode.name ?? "пункт назначения") ")
                break
            }

            let nextNodeId = path[i + 1]
            guard let nextNode = points.first(where: { $0.id == nextNodeId }) else { continue }

            // Вертикальное перемещение
            if currentNode.floor != nextNode.floor {
                if let connection = verticalConnections.first(where: { $0.nodes.contains(currentNode.id) && $0.nodes.contains(nextNode.id) }) {
                    let action = connection.type == "elevator" ?
                        "Вызовите лифт \(connection.name) на \(nextNode.floor) этаж" :
                        "Поднимитесь по лестнице \(connection.name) на \(nextNode.floor) этаж"
                    instructions.append(action)
                    previousDirection = nil
                    continue
                }
            }

            // Горизонтальное движение
            let direction = calculateDirection(from: currentNode, to: nextNode)
            if previousDirection == nil {
                instructions.append("Начните движение \(direction) от \(currentNode.name ?? "текущей позиции")")
            } else if direction != previousDirection {
                let turn = getTurn(from: previousDirection!, to: direction)
                instructions.append("Поверните \(turn)")
            }

            // Ориентиры каждые 3 шага
            if i % 3 == 0, !currentNode.landmarks.isEmpty {
                instructions.append("Ориентир: \(currentNode.landmarks.joined(separator: ", "))")
            }

            previousDirection = direction
        }

        return instructions
    }

    /// Расчет направления между узлами
    private func calculateDirection(from start: Point, to end: Point) -> String {
        let dx = end.x - start.x
        let dy = end.y - start.y
        let angle = atan2(dy, dx) * 180 / .pi // Угол в градусах

        if angle >= -45 && angle < 45 { return "прямо" }
        if angle >= 45 && angle < 135 { return "направо" }
        if angle >= -135 && angle < -45 { return "налево" }
        return "назад"
    }

    /// Определение поворота
    private func getTurn(from previous: String, to current: String) -> String {
        let turns: [String: String] = [
            "прямо->направо": "направо",
            "прямо->налево": "налево",
            "направо->прямо": "налево",
            "налево->прямо": "направо"
        ]
        return turns["\(previous)->\(current)"] ?? "в указанном направлении"
    }
}



