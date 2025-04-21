//
//  DeadlineModel.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 16.04.2025.
//
import Foundation
import SwiftData
import SwiftUICore

@Model
class Deadline: Identifiable {
    var id = UUID()
    var priority: Priority
    var title: String
    var details: String
    var date: Date
    
    init(priority: Priority, title: String, details: String, date: Date) {
        self.priority = priority
        self.title = title
        self.details = details
        self.date = date
    }
}

enum Priority: String, CaseIterable, Codable {
    case low = "Низкий"
    case normal = "Средний"
    case high = "Высокий"
    
    var color: Color {
        switch self {
        case .low: return .green
        case .normal: return .orange
        case .high: return .red
        }
    }
}
