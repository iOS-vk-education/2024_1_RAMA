//
//  WeekView.swift
//  MAIApp
//
//  Created by Андрей  Насибулин  on 18.11.2024.
//

import SwiftUI
import Foundation

struct WeekView: View {
    @Binding var weekNumber: Int
//    let week: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("неделя")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(weekRange(for: weekNumber))
                    .font(.headline)
            }
            .foregroundColor(.black)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
    }
    
    func weekRange(for weekNumber: Int) -> String {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ru_RU") // Русская локаль
        calendar.firstWeekday = 2 // Устанавливаем понедельник как первый день недели
        
        let currentYear = calendar.component(.year, from: Date())
        
        // Находим 1 января текущего года
        guard let startOfYear = calendar.date(from: DateComponents(year: currentYear, month: 1, day: 1)) else {
            return ""
        }
        
        // Найдем первый понедельник года
        var firstMonday = startOfYear
        while calendar.component(.weekday, from: firstMonday) != calendar.firstWeekday {
            firstMonday = calendar.date(byAdding: .day, value: 1, to: firstMonday)!
        }
        
        // Переходим к нужной неделе
        let daysToAdd = (weekNumber - 1) * 7
        guard let startOfWeek = calendar.date(byAdding: .day, value: daysToAdd, to: firstMonday) else {
            return ""
        }
        
        // Определяем конец недели (воскресенье)
        guard let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
            return ""
        }
        
        // Форматируем даты
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM" // Формат для короткой записи дня и месяца
        
        let startDateString = dateFormatter.string(from: startOfWeek)
        let endDateString = dateFormatter.string(from: endOfWeek)
        
        return "\(startDateString) - \(endDateString)"
    }
}
#Preview {
//    WeekView()
}
