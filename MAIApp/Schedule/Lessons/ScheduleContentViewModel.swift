//
//  ScheduleContentViewModel.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 09.04.2025.
//

import Foundation
import SwiftUI

class ScheduleContentViewModel: ObservableObject {
    
    
    // MARK: - Extension
    
}

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.date(from: self)
    }
    //Форматирует строку, делая первую букву каждого слова заглавной, остальные — строчными.
    func toCapitalizedCase() -> String {
        self
            .lowercased()
            .components(separatedBy: " ")
            .map { $0.capitalized }
            .joined(separator: " ")
    }
}
