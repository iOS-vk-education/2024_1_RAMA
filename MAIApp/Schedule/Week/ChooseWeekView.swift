//
//  ChooseWeekView.swift
//  MAIApp
//
//  Created by Руслан on 08.12.2024.
//

import SwiftUI

struct ChooseWeekView: View {
    @Binding var weekNumber: Int
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(Array(allWeeksInYear().enumerated()), id: \.element) { index, week in
                        Text(week)
                            .padding(8)
                            .frame(maxWidth: .infinity)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.gray, lineWidth: 1)
                                        .opacity(0.25)
                                    )
                            .font(.subheadline)
                            .onTapGesture {
                                weekNumber = index + 1
                                dismiss()
                            }
                    }
                }
                .padding()
                .navigationTitle("Неделя")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    func allWeeksInYear() -> [String] {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ru_RU") // Русская локаль
        calendar.firstWeekday = 2 // Понедельник — первый день недели
        
        let currentYear = calendar.component(.year, from: Date())
        var weeks: [String] = []
        
        // Найдем 1 января текущего года
        guard let startOfYear = calendar.date(from: DateComponents(year: currentYear, month: 1, day: 1)) else {
            return []
        }
        
        // Найдем первый понедельник года
        var firstMonday = startOfYear
        while calendar.component(.weekday, from: firstMonday) != calendar.firstWeekday {
            firstMonday = calendar.date(byAdding: .day, value: 1, to: firstMonday)!
        }
        
        // Перебираем недели
        var currentMonday = firstMonday
        while calendar.component(.year, from: currentMonday) == currentYear {
            // Начало недели
            let startDate = calendar.startOfDay(for: currentMonday)
            
            // Конец недели (воскресенье)
            guard let endDate = calendar.date(byAdding: .day, value: 6, to: startDate) else {
                break
            }
            
            // Форматируем даты
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM" // Формат дня и месяца
            
            let startDateString = dateFormatter.string(from: startDate)
            let endDateString = dateFormatter.string(from: endDate)
            
            // Добавляем строку в массив
            weeks.append("\(startDateString) - \(endDateString)")
            
            // Переходим к следующей неделе
            guard let nextMonday = calendar.date(byAdding: .day, value: 7, to: currentMonday) else {
                break
            }
            currentMonday = nextMonday
        }
        
        return weeks
    }
}

#Preview {
    ChooseWeekView(weekNumber: .constant(52))
}
