//
//  WeekModel.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 02.02.2025.
//

import Foundation

struct WeekData {
    let number: Int       // Номер недели (1, 2, 3...)
    let startDate: Date   // Понедельник недели
    let endDate: Date     // Воскресенье недели
    var displayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        return "\(formatter.string(from: startDate)) – \(formatter.string(from: endDate))"
    }
}
